import 'package:just_audio/just_audio.dart';

abstract class IAudioPlayer {
  Future<void> setUrl(String url);
  Future<void> setAudioSource(AudioSource source);
  Future<void> play();
  Future<void> pause();
  Future<void> setSpeed(double speed);
  Future<void> stop();
  Future<void> seek(Duration position);
  Stream<PlayerState> get playerStateStream;
  Stream<Duration> get positionStream;
  Stream<Duration?> get durationStream;
  Future<void> dispose();
}

enum PlayerStatus { idle, loading, playing, paused, completed, error }

class PlayerState {
  final PlayerStatus status;
  final String? errorMessage;
  const PlayerState(this.status, [this.errorMessage]);
}

class JustAudioPlayer implements IAudioPlayer {
  final AudioPlayer _player;

  JustAudioPlayer({AudioPlayer? audioPlayer})
      : _player = audioPlayer ?? AudioPlayer();

  @override
  Future<void> setUrl(String url) async {
    await _player.setUrl(url);
  }

  @override
  Future<void> setAudioSource(AudioSource source) async {
    await _player.setAudioSource(source);
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> setSpeed(double speed) => _player.setSpeed(speed);

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Stream<PlayerState> get playerStateStream =>
      _player.playerStateStream.map((state) {
        if (state.playing &&
            state.processingState != ProcessingState.completed) {
          return PlayerState(PlayerStatus.playing);
        }
        switch (state.processingState) {
          case ProcessingState.idle:
            return PlayerState(PlayerStatus.idle);
          case ProcessingState.loading:
          case ProcessingState.buffering:
            return PlayerState(PlayerStatus.loading);
          case ProcessingState.ready:
            return state.playing
                ? PlayerState(PlayerStatus.playing)
                : PlayerState(PlayerStatus.paused);
          case ProcessingState.completed:
            return PlayerState(PlayerStatus.completed);
        }
      });

  @override
  Stream<Duration> get positionStream => _player.positionStream;

  @override
  Stream<Duration?> get durationStream => _player.durationStream;

  @override
  Future<void> dispose() => _player.dispose();
}
