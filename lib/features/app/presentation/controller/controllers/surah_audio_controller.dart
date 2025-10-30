import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' hide PlayerState;
import 'package:just_audio_background/just_audio_background.dart';
import 'package:test_app/core/services/audio_player_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/file_storage_service.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';

class PreparedReciterData {
  final List<AudioSource> sources;
  final List<Duration> ayahDurations;
  final Duration totalDuration;
  final String folderName;
  final String firstUri;

  PreparedReciterData({
    required this.sources,
    required this.ayahDurations,
    required this.totalDuration,
    required this.folderName,
    required this.firstUri,
  });
}

class ProgressData {
  final Duration position;
  final Duration buffered;
  final Duration total;

  ProgressData({
    required this.position,
    required this.buffered,
    required this.total,
  });
}

class SurahAudioController {
  late final ValueNotifier<bool> isAudioPlayingNotifier;
  late final ValueNotifier<bool> isPreparingNotifier;
  late final ValueNotifier<double> positionNotifier;

  late final TafsirPageController tafsirPageController;
  late final IAudioPlayer audioPlayer;
  late final IFileStorageService fileStorage;

  StreamSubscription<Duration>? positionSub;
  StreamSubscription<PlayerState>? _playerStateSub;
  StreamSubscription<Duration>? _bufferedSub;
  StreamSubscription<Duration?>? _durationSub;

  bool _isPrepared = false;
  bool _isDisposed = false;

  final Map<String, PreparedReciterData> _reciterCache = {};

  List<Duration> _currentAyahDurations = [];
  Duration _currentTotalDuration = Duration.zero;

  final StreamController<ProgressData> _progressController =
      StreamController<ProgressData>.broadcast();
  Stream<ProgressData> get progressStream => _progressController.stream;

  Duration _lastPosition = Duration.zero;
  Duration _lastBuffered = Duration.zero;
  Duration _lastTotal = Duration.zero;

  SurahAudioController({required this.tafsirPageController}) {
    isAudioPlayingNotifier = ValueNotifier<bool>(false);
    isPreparingNotifier = ValueNotifier<bool>(false);
    positionNotifier = ValueNotifier<double>(0.0);
    audioPlayer = JustAudioPlayer(AudioPlayer());
    fileStorage = sl<IFileStorageService>();
  }

  void dispose() {
    _isDisposed = true;
    positionSub?.cancel();
    _playerStateSub?.cancel();
    _bufferedSub?.cancel();
    _durationSub?.cancel();
    if (!_progressController.isClosed) _progressController.close();
    positionNotifier.dispose();
    isAudioPlayingNotifier.dispose();
    isPreparingNotifier.dispose();
    audioPlayer.dispose();
  }

  Duration _sumBefore(List<Duration> durations, int index) {
    if (index <= 0) return Duration.zero;
    Duration s = Duration.zero;
    for (int i = 0; i < index && i < durations.length; i++) {
      s += durations[i];
    }
    return s;
  }

  void _ensureSubscriptions() {
    if (_isDisposed) return;

    positionSub ??= audioPlayer.positionStream.listen((pos) {
      _lastPosition = pos;
      _emitProgress();

      if (_isDisposed || _currentAyahDurations.isEmpty) return;

      final currentIndex = (audioPlayer.currentIndex ?? 0)
          .clamp(0, _currentAyahDurations.length - 1);
      final before = _sumBefore(_currentAyahDurations, currentIndex);
      final overallPosition = before + pos;

      final currentAyah =
          (currentIndex + 1).clamp(1, _currentAyahDurations.length);
      tafsirPageController.selectedAyah.value = currentAyah;

      final totalMs = _currentTotalDuration.inMilliseconds == 0
          ? 1
          : _currentTotalDuration.inMilliseconds;
      final percent =
          (overallPosition.inMilliseconds / totalMs).clamp(0.0, 1.0);
      positionNotifier.value = percent;
    });

    _bufferedSub ??= audioPlayer.bufferedPositionStream.listen((buf) {
      if (_isDisposed) return;
      _lastBuffered = buf;
      _emitProgress();
    });

    _durationSub ??= audioPlayer.durationStream.listen((dur) {
      if (_isDisposed) return;
      _lastTotal = dur ?? Duration.zero;
      _emitProgress();
    });

    _playerStateSub ??= audioPlayer.playerStateStream.listen((state) async {
      if (_isDisposed) return;

      if (state.status == PlayerStatus.error) {
        isAudioPlayingNotifier.value = false;
        tafsirPageController.selectedAyah.value = -1;
        await audioPlayer.stop();
      } else if (state.status == PlayerStatus.completed) {
        tafsirPageController.selectedAyah.value = -1;
        isAudioPlayingNotifier.value = false;
      } else if (state.status == PlayerStatus.playing) {
        isAudioPlayingNotifier.value = true;
      } else if (state.status == PlayerStatus.paused) {
        isAudioPlayingNotifier.value = false;
      }
    });
  }

  void _emitProgress() {
    if (_progressController.isClosed) return;
    _progressController.add(ProgressData(
      position: _lastPosition,
      buffered: _lastBuffered,
      total: _lastTotal,
    ));
  }

  Future<void> prepareSurahAudio({required bool isChange}) async {
    if (_isPrepared || isPreparingNotifier.value || _isDisposed) return;

    isPreparingNotifier.value = true;

    final ReciterEntity? reciter =
        tafsirPageController.currentReciterNotifier.value;
    if (reciter == null) {
      isPreparingNotifier.value = false;
      return;
    }

    final cacheKey = reciter.name;
    final folderName =
        "${reciter.name}_${tafsirPageController.surahEntity.name}";
    final totalAyahs = tafsirPageController.surahEntity.numberOfAyat;
    if (totalAyahs <= 0) {
      isPreparingNotifier.value = false;
      return;
    }

    isAudioPlayingNotifier.value = false;
    tafsirPageController.selectedAyah.value = -1;

    if (_reciterCache.containsKey(cacheKey)) {
      final cached = _reciterCache[cacheKey]!;
      _currentAyahDurations = cached.ayahDurations;
      _currentTotalDuration = cached.totalDuration;
      await audioPlayer.setAudioSources(cached.sources);
      _ensureSubscriptions();
      isAudioPlayingNotifier.value = true;
      _isPrepared = true;
      isPreparingNotifier.value = false;
      await audioPlayer.play();
      return;
    }

    final resolvedFiles = await Future.wait(List.generate(
      totalAyahs,
      (i) => fileStorage.getFile(
        folderName: folderName,
        fileName: '${i + 1}',
        extension: 'mp3',
      ),
    ));

    final ayahDurations = await Future.wait(resolvedFiles.map((file) async {
      final tempPlayer = AudioPlayer();
      await tempPlayer.setFilePath(file.path);
      final duration = tempPlayer.duration ?? Duration.zero;
      await tempPlayer.dispose();
      return duration;
    }));

    final sources = resolvedFiles.asMap().entries.map((entry) {
      final index = entry.key;
      final file = entry.value;

      return AudioSource.uri(
        Uri.file(file.path),
        tag: index == 0
            ? MediaItem(
                title: tafsirPageController.surahEntity.name,
                id: resolvedFiles.first.uri.toString(),
                artist: reciter.name,
                artUri: Uri.parse(reciter.image),
              )
            : null,
      );
    }).toList();

    await audioPlayer.setAudioSources(sources);

    final totalDuration =
        ayahDurations.fold(Duration.zero, (prev, d) => prev + d);

    final prepared = PreparedReciterData(
        sources: sources,
        ayahDurations: ayahDurations,
        totalDuration: totalDuration,
        folderName: folderName,
        firstUri: resolvedFiles.first.uri.toString());
    _reciterCache[cacheKey] = prepared;

    _currentAyahDurations = ayahDurations;
    _currentTotalDuration = totalDuration;
    _ensureSubscriptions();

    if (isChange) return;

    isAudioPlayingNotifier.value = true;
    _isPrepared = true;
    isPreparingNotifier.value = false;
    await audioPlayer.play();
  }

  Future<void> changeReciter(ReciterEntity newReciter) async {
    if (_isDisposed) return;

    final wasPlaying = isAudioPlayingNotifier.value;

    Duration currentPosInItem = Duration.zero;
    currentPosInItem = await audioPlayer.positionStream.first;

    final oldIndex = (audioPlayer.currentIndex ?? 0);
    final beforeOld = _sumBefore(_currentAyahDurations, oldIndex);
    final overallMs = beforeOld + currentPosInItem;

    await audioPlayer.pause();

    tafsirPageController.currentReciterNotifier.value = newReciter;

    _isPrepared = false;
    isPreparingNotifier.value = true;

    await prepareSurahAudio(isChange: true);

    int targetIndex = 0;
    Duration offsetInside = Duration.zero;
    Duration cumulative = Duration.zero;
    for (int i = 0; i < _currentAyahDurations.length; i++) {
      cumulative += _currentAyahDurations[i];
      if (overallMs < cumulative) {
        targetIndex = i;
        final prev = cumulative - _currentAyahDurations[i];
        offsetInside = Duration(
          milliseconds: (overallMs - prev)
              .inMilliseconds
              .clamp(0, _currentAyahDurations[i].inMilliseconds),
        );
        break;
      }
    }
    if (overallMs >= _currentTotalDuration) {
      targetIndex = _currentAyahDurations.length - 1;
      offsetInside = _currentAyahDurations.last;
    }

    await audioPlayer.seekToIndex(offsetInside, targetIndex);

    _isPrepared = true;
    isPreparingNotifier.value = false;

    if (wasPlaying) {
      await audioPlayer.play();
    }
  }

  Future<void> resumeSurah() async {
    if (_isDisposed) return;

    if (!_isPrepared) {
      await prepareSurahAudio(isChange: false);
      return;
    }

    final state = await audioPlayer.playerStateStream.first;

    if (state.status == PlayerStatus.completed) {
      // السورة خلصت → نرجع لأول آية
      await audioPlayer.seekToIndex(Duration.zero, 0);
      return;
    }

    await audioPlayer.play();
  }

  Future<void> setSpeed(double value) async {
    await audioPlayer.setSpeed(value);
  }

  Future<void> pauseSurah() async {
    await audioPlayer.pause();
  }

  Future<void> seekToNextAyah() async {
    await audioPlayer.seekToIndex(Duration.zero, audioPlayer.currentIndex! + 1);
  }

  Future<void> seekToPreviousAyah() async {
    await audioPlayer.seekToIndex(Duration.zero, audioPlayer.currentIndex! - 1);
  }
}
