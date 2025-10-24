import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' hide PlayerState;
import 'package:test_app/core/services/audio_player_service.dart';

class AyahAudioCardController {
  final AudioSource audioSource;
  final bool isRepeat;

  late final ValueNotifier<Duration> position;
  late final ValueNotifier<Duration> duration;
  late final ValueNotifier<bool> isAudioPlayingNotifier;
  late final ValueNotifier<double> speed;
  late final ValueNotifier<Offset> offset;

  late final IAudioPlayer _audioPlayer;
  late OverlayEntry _entry;

  bool isCompleted = false;

  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<Duration?>? _durationSub;
  StreamSubscription<PlayerState>? _stateSub;

  AyahAudioCardController({required this.audioSource, this.isRepeat = false}) {
    isAudioPlayingNotifier = ValueNotifier<bool>(false);
    position = ValueNotifier<Duration>(Duration.zero);
    duration = ValueNotifier(const Duration(seconds: 1));
    speed = ValueNotifier<double>(1.0);
    offset = ValueNotifier(const Offset(50, 100));

    _audioPlayer = JustAudioPlayer(AudioPlayer());
    _init();
  }

  void setEntry(OverlayEntry entry) {
    _entry = entry;
  }

  Future<void> _init() async {
    await _audioPlayer.setAudioSource(audioSource);
    _positionSub = _audioPlayer.positionStream.listen((pos) {
      position.value = pos;
    });

    _durationSub = _audioPlayer.durationStream.listen((dur) {
      if (dur != null) duration.value = dur;
    });

    _stateSub = _audioPlayer.playerStateStream.listen((state) {
      if (state.status == PlayerStatus.completed) {
        if (isRepeat) _audioPlayer.seek(Duration.zero);
        isCompleted = true;
        isAudioPlayingNotifier.value = false;
      } else if (state.status == PlayerStatus.playing) {
        isAudioPlayingNotifier.value = true;
      } else if (state.status == PlayerStatus.paused) {
        isAudioPlayingNotifier.value = false;
      } else if (state.status == PlayerStatus.error) {
        isAudioPlayingNotifier.value = false;
      }
    });

    await _audioPlayer.play();
  }

  void pause() async {
    await _audioPlayer.pause();
  }

  void resume() async {
    if (isCompleted) {
      await _audioPlayer.seek(Duration.zero);
      isCompleted = false;
    }

    await _audioPlayer.play();
  }

  Future<void> setSpeed(double newSpeed) async {
    speed.value = newSpeed;
    await _audioPlayer.setSpeed(newSpeed);
  }

  void seek(Duration pos) => _audioPlayer.seek(pos);

  void updateOffset(Offset delta) => offset.value += delta;

  void removeCard() {
    dispose();
    _entry.remove();
  }

  void dispose() {
    _positionSub?.cancel();
    _durationSub?.cancel();
    _stateSub?.cancel();

    position.dispose();
    duration.dispose();
    isAudioPlayingNotifier.dispose();
    offset.dispose();
    speed.dispose();
    _audioPlayer.dispose();
  }
}
