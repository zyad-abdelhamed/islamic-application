import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:test_app/core/services/audio_player_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';

class AyahAudioCardController {
  final AudioSource audioSource;
  final ValueNotifier<Duration> position = ValueNotifier(Duration.zero);
  final ValueNotifier<PlayerStatus> status = ValueNotifier(PlayerStatus.idle);
  final ValueNotifier<double> speed = ValueNotifier(1.0);
  final ValueNotifier<Offset> offset = ValueNotifier(const Offset(50, 100));

  late final IAudioPlayer _audioPlayer;
  late OverlayEntry _entry;

  AyahAudioCardController({required this.audioSource}) {
    _audioPlayer = sl<IAudioPlayer>();
    _init();
  }

  void setEntry(OverlayEntry entry) {
    _entry = entry;
  }

  Future<void> _init() async {
    await _audioPlayer.setAudioSource(audioSource);
    await _audioPlayer.play();

    _audioPlayer.positionStream.listen((pos) => position.value = pos);
    _audioPlayer.playerStateStream.listen((state) {
      status.value = state.status;
      if (state.status == PlayerStatus.completed) {
        position.value = Duration.zero;
      }
    });
  }

  void togglePlayPause() async {
    if (status.value == PlayerStatus.playing) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();
    }
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
    position.dispose();
    status.dispose();
    offset.dispose();
    speed.dispose();
    _audioPlayer.dispose();
  }
}