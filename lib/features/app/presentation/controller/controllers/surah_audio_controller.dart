import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:test_app/core/services/audio_player_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/file_storage_service.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';

class SurahAudioController {
  late final ValueNotifier<bool> isAudioPlayingNotifier;
  final StreamController<double> _audioProgressController =
      StreamController<double>.broadcast();
  Stream<double> get audioPositionStream => _audioProgressController.stream;

  late final TafsirPageController tafsirPageController;
  late final IAudioPlayer audioPlayer;
  late final IFileStorageService fileStorage;

  bool _isPrepared = false;
  bool get isPrepared => _isPrepared;

  SurahAudioController({required this.tafsirPageController}) {
    isAudioPlayingNotifier = ValueNotifier<bool>(false);

    audioPlayer = JustAudioPlayer(AudioPlayer());
    fileStorage = sl<IFileStorageService>();
  }

  void dispose() {
    isAudioPlayingNotifier.dispose();
    _audioProgressController.close();
    audioPlayer.dispose();
  }

// لما شغلت الصوت وجيت اطلع مالصفحه جه كده انا عامل  ديسبوس للصوت فالديسبوس بس لما رجعت والصوت اما كنت وقفت الصوت بعد مشغلته مجابش الايرور دهه Exception has occurred.
// FlutterError (A ValueNotifier<bool> was used after being disposed.
// Once you have called dispose() on a ValueNotifier<bool>, it can no longer be used.)
  Future<void> prepareSurahAudio() async {
    if (_isPrepared) return;

    List<Duration> ayahDurations = [];

    final reciter = tafsirPageController.currentReciterNotifier.value;
    if (reciter == null) return;

    final folderName =
        "${reciter.name}_${tafsirPageController.surahEntity.name}";
    final totalAyahs = tafsirPageController.surahEntity.numberOfAyat;
    if (totalAyahs <= 0) return;

    isAudioPlayingNotifier.value = false;
    tafsirPageController.selectedAyah.value = null;

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

    final duration = await audioPlayer.setAudioSources(sources);
    await audioPlayer.play();

    isAudioPlayingNotifier.value = true;
    _isPrepared = true;

    audioPlayer.positionStream.listen((pos) {
      Duration cumulative = Duration.zero;
      int currentAyah = 1;

      for (int i = 0; i < ayahDurations.length; i++) {
        cumulative += ayahDurations[i];
        if (pos < cumulative) {
          currentAyah = i + 1;
          break;
        }
      }

      tafsirPageController.selectedAyah.value = currentAyah;

      final totalMs = duration?.inMilliseconds ?? cumulative.inMilliseconds;
      final percent = (pos.inMilliseconds / totalMs).clamp(0.0, 1.0);
      _audioProgressController.add(percent);
    });

    audioPlayer.playerStateStream.listen((state) {
      if (state.status == PlayerStatus.completed) {
        isAudioPlayingNotifier.value = false;
        tafsirPageController.selectedAyah.value = null;
        audioPlayer.stop();
      }
    });
  }

  Future<void> resumeSurah() async {
    isAudioPlayingNotifier.value = true;
    await audioPlayer.play();
  }

  Future<void> pauseSurah() async {
    isAudioPlayingNotifier.value = false;
    await audioPlayer.pause();
  }

  Future<void> stopSurah() async {
    isAudioPlayingNotifier.value = false;
    await audioPlayer.stop();
  }
}
