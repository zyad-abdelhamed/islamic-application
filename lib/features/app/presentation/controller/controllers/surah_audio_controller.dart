import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' hide PlayerState;
import 'package:test_app/core/services/audio_player_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/file_storage_service.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';

class SurahAudioController {
  late final ValueNotifier<bool> isAudioPlayingNotifier;
  late final ValueNotifier<bool> isPreparingNotifier;
  late final ValueNotifier<double> positionNotifier;

  late final TafsirPageController tafsirPageController;
  late final IAudioPlayer audioPlayer;
  late final IFileStorageService fileStorage;

  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<PlayerState>? _playerStateSub;

  bool _isPrepared = false;
  bool _isDisposed = false;

  SurahAudioController({required this.tafsirPageController}) {
    isAudioPlayingNotifier = ValueNotifier<bool>(false);
    isPreparingNotifier = ValueNotifier<bool>(false);
    positionNotifier = ValueNotifier<double>(0.0);
    audioPlayer = JustAudioPlayer(AudioPlayer());
    fileStorage = sl<IFileStorageService>();
  }

  void dispose() {
    _isDisposed = true;

    _positionSub?.cancel();
    _playerStateSub?.cancel();

    positionNotifier.dispose();
    isAudioPlayingNotifier.dispose();
    isPreparingNotifier.dispose();

    audioPlayer.dispose();
  }

  Future<void> prepareSurahAudio() async {
    if (_isPrepared || isPreparingNotifier.value || _isDisposed) return;

    isPreparingNotifier.value = true;

    List<Duration> ayahDurations = [];

    final reciter = tafsirPageController.currentReciterNotifier.value;
    if (reciter == null) {
      if (!_isDisposed) isPreparingNotifier.value = false;
      return;
    }

    final folderName =
        "${reciter.name}_${tafsirPageController.surahEntity.name}";
    final totalAyahs = tafsirPageController.surahEntity.numberOfAyat;
    if (totalAyahs <= 0) {
      if (!_isDisposed) isPreparingNotifier.value = false;
      return;
    }

    if (!_isDisposed) {
      isAudioPlayingNotifier.value = false;
      tafsirPageController.selectedAyah.value = null;
    }

    final resolvedFiles = await Future.wait(
      List.generate(
        totalAyahs,
        (i) => fileStorage.getFile(
          folderName: folderName,
          fileName: '${i + 1}',
          extension: 'mp3',
        ),
      ),
    );

    ayahDurations = await Future.wait(
      resolvedFiles.map((file) async {
        final tempPlayer = AudioPlayer();
        await tempPlayer.setFilePath(file.path);
        final duration = tempPlayer.duration ?? Duration.zero;
        await tempPlayer.dispose();
        return duration;
      }),
    );

    final sources = await Future.wait(
      resolvedFiles
          .map((file) => Future.value(AudioSource.uri(Uri.file(file.path)))),
    );

    await audioPlayer.setAudioSources(sources);

    // احسب once بعد التحضير
    final totalDuration = ayahDurations.fold<Duration>(
      Duration.zero,
      (prev, d) => prev + d,
    );

// helper to sum durations up to index (exclusive)
    Duration sumBefore(int index) {
      if (index <= 0) return Duration.zero;
      Duration s = Duration.zero;
      for (int i = 0; i < index && i < ayahDurations.length; i++) {
        s += ayahDurations[i];
      }
      return s;
    }

// استخدام currentIndex + position داخل الـ item
    _positionSub ??= audioPlayer.positionStream.listen((pos) async {
      if (_isDisposed) return;

      // currentIndex يعطينا رقم الـ item الحالي (آية - 0-based)
      final currentIndex =
          (audioPlayer.currentIndex ?? 0).clamp(0, ayahDurations.length - 1);

      // حساب الزمن الكلي = زمن كل الآيات السابقة + الموضع الحالي داخل الآية
      final before = sumBefore(currentIndex);
      final overallPosition = before + pos;

      // تعيين الآية الحالية (1-based)
      final currentAyah = (currentIndex + 1).clamp(1, ayahDurations.length);

      // تحديث الآية بطريقة آمنة
      tafsirPageController.selectedAyah.value = currentAyah;

      // حساب النسبة على أساس مجموع المدد الكامل (حماية من صفر)
      final totalMs =
          totalDuration.inMilliseconds == 0 ? 1 : totalDuration.inMilliseconds;
      final percent =
          (overallPosition.inMilliseconds / totalMs).clamp(0.0, 1.0);

      positionNotifier.value = percent;
    });

    _playerStateSub ??= audioPlayer.playerStateStream.listen((state) async {
      if (_isDisposed) return;

      if (state.status == PlayerStatus.error) {
        isAudioPlayingNotifier.value = false;
        tafsirPageController.selectedAyah.value = null;
        await audioPlayer.stop();
      } else if (state.status == PlayerStatus.completed) {
        tafsirPageController.selectedAyah.value = null;
        isAudioPlayingNotifier.value = false;
      } else if (state.status == PlayerStatus.playing) {
        isAudioPlayingNotifier.value = true;
      } else if (state.status == PlayerStatus.paused) {
        isAudioPlayingNotifier.value = false;
      }
    });

    if (!_isDisposed) isAudioPlayingNotifier.value = true;

    _isPrepared = true;
    if (!_isDisposed) isPreparingNotifier.value = false;
    await audioPlayer.play();
  }

  Future<void> resumeSurah() async {
    if (_isDisposed) return;

    if (!_isPrepared) {
      await prepareSurahAudio();
      return;
    }

    // ضع المؤشر في البداية قبل التشغيل لضمان أن play يعمل بعد الاكتمال
    try {
      await audioPlayer.seekToIndex(Duration.zero, 0); // الرجوع لأول آية
    } catch (_) {
      // ignore seek errors, بعد ذلك نجرب التشغيل
    }

    await audioPlayer.play();
  }

  Future<void> pauseSurah() async {
    if (_isDisposed) return;
    await audioPlayer.pause();
  }

  void resetPreparation() {
    if (_isDisposed) return;
    audioPlayer.stop();
    isPreparingNotifier.value = false;
    _isPrepared = false;
  }
}
