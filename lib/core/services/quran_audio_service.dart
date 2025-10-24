// import 'dart:async';
// import 'package:audio_service/audio_service.dart';
// import 'package:just_audio/just_audio.dart';

// enum QuranPlayerStatus {
//   idle,
//   loading,
//   playing,
//   paused,
//   completed,
//   error,
// }

// class QuranPlayerState {
//   final QuranPlayerStatus status;
//   final String? errorMessage;

//   const QuranPlayerState(this.status, [this.errorMessage]);
// }

// abstract class IQuranAudioService {
//   Future<void> loadNotificationDetails({
//     String? album,
//     required String title,
//     required String url,
//     required String artist,
//     Uri? imageUri,
//   });

//   Future<void> play();
//   Future<void> pause();
//   Future<void> stop();
//   Future<void> seek(Duration position);
//   Future<void> seekToIndex(Duration position, int index);

//   Stream<QuranPlayerState> get playerStateStream;
//   Stream<Duration> get positionStream;
//   Stream<Duration> get bufferedPositionStream;
//   Stream<Duration?> get durationStream;
// }

// class QuranAudioService implements IQuranAudioService {
//   late final AudioPlayer _player;
//   late final AudioHandler _handler;

//   final StreamController<QuranPlayerState> _stateController = StreamController.broadcast();

//   QuranAudioService._(this._player, this._handler) {
//     _player.playbackEventStream.listen((event) {
//       final playing = _player.playing;
//       final processingState = _player.processingState;

//       final mappedState = {
//         ProcessingState.idle: QuranPlayerStatus.idle,
//         ProcessingState.loading: QuranPlayerStatus.loading,
//         ProcessingState.buffering: QuranPlayerStatus.loading,
//         ProcessingState.ready: playing ? QuranPlayerStatus.playing : QuranPlayerStatus.paused,
//         ProcessingState.completed: QuranPlayerStatus.completed,
//       }[processingState]!;

//       _onStateChanged(QuranPlayerState(mappedState));
//     });
//   }

//   static Future<QuranAudioService> init() async {
//     final player = AudioPlayer();

//     final handler = await AudioService.init(
//       builder: () => _QuranAudioHandler(player),
//       config: const AudioServiceConfig(
//         androidNotificationChannelId: 'com.quran.audio',
//         androidNotificationChannelName: 'Quran Audio',
//         androidNotificationOngoing: true,
//       ),
//     );

//     return QuranAudioService._(player, handler);
//   }

//   void _onStateChanged(QuranPlayerState state) {
//     if (!_stateController.isClosed) {
//       _stateController.add(state);
//     }
//   }

//   @override
//   Stream<QuranPlayerState> get playerStateStream => _stateController.stream;

//   @override
//   Stream<Duration> get positionStream => _player.positionStream;

//   @override
//   Stream<Duration> get bufferedPositionStream => _player.bufferedPositionStream;

//   @override
//   Stream<Duration?> get durationStream => _player.durationStream;

//   @override
//   Future<void> loadNotificationDetails({
//     String? album,
//     required String title,
//     required String url,
//     required String artist,
//     Uri? imageUri,
//   }) async {
//     final mediaItem = MediaItem(
//       id: url,
//       album: album,
//       title: title,
//       artist: artist,
//       duration: const Duration(minutes: 1),
//       artUri: imageUri,
//     );

//     await _handler.updateMediaItem(mediaItem);

//     try {
//       await _player.setUrl(url);
//       _onStateChanged(const QuranPlayerState(QuranPlayerStatus.paused));
//     } catch (e) {
//       _onStateChanged(QuranPlayerState(QuranPlayerStatus.error, e.toString()));
//     }
//   }

//   @override
//   Future<void> play() async {
//     try {
//       await _player.play();
//       _onStateChanged(const QuranPlayerState(QuranPlayerStatus.playing));
//     } catch (e) {
//       _onStateChanged(QuranPlayerState(QuranPlayerStatus.error, e.toString()));
//     }
//   }

//   @override
//   Future<void> pause() async {
//     try {
//       await _player.pause();
//       _onStateChanged(const QuranPlayerState(QuranPlayerStatus.paused));
//     } catch (e) {
//       _onStateChanged(QuranPlayerState(QuranPlayerStatus.error, e.toString()));
//     }
//   }

//   @override
//   Future<void> stop() async {
//     try {
//       await _player.stop();
//       _onStateChanged(const QuranPlayerState(QuranPlayerStatus.idle));
//     } catch (e) {
//       _onStateChanged(QuranPlayerState(QuranPlayerStatus.error, e.toString()));
//     }
//   }

//   @override
//   Future<void> seek(Duration position) async {
//     try {
//       await _player.seek(position);
//     } catch (e) {
//       _onStateChanged(QuranPlayerState(QuranPlayerStatus.error, e.toString()));
//     }
//   }

//   @override
//   Future<void> seekToIndex(Duration position, int index) async {
//     await _player.seek(position, index: index);
//   }

//   void dispose() {
//     _stateController.close();
//     _player.dispose();
//   }
// }

// class _QuranAudioHandler extends BaseAudioHandler with SeekHandler {
//   final AudioPlayer _player;

//   _QuranAudioHandler(this._player);

//   @override
//   Future<void> play() => _player.play();

//   @override
//   Future<void> pause() => _player.pause();

//   @override
//   Future<void> stop() => _player.stop();

//   @override
//   Future<void> seek(Duration position) => _player.seek(position);
// }
