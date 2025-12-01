import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:test_app/core/services/audio_player_service.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/domain/entities/radio_station_entity.dart';

class RadioStationStreamController extends ChangeNotifier {
  late final RadioStationEntity station;
  late final IAudioPlayer audioPlayer;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isAudioSourceSet = false;

  String _statusText = "متوقف";
  String get statusText => _statusText;

  Color _statusTextColor = AppColors.grey;
  Color get statusTextColor => _statusTextColor;

  String _buttonLabel = "تشغيل";
  String get buttonLabel => _buttonLabel;

  IconData _buttonIcon = Icons.play_arrow;
  IconData get buttonIcon => _buttonIcon;

  RadioStationStreamController() {
    audioPlayer = JustAudioPlayer(AudioPlayer());
    station = RadioStationEntity(
      name: "القاهرة",
      streamUrl: 'https://www.maspero.eg/stream/7',
    );
  }

  Future<void> togglePlay() async {
    try {
      if (_isPlaying) {
        await audioPlayer.stop();
        _isPlaying = false;
        _setStoppedState();
      } else {
        _setLoadingState();
        notifyListeners();

        if (!_isAudioSourceSet) {
          final AudioSource source =
              AudioSource.uri(Uri.parse(station.streamUrl));

          await audioPlayer.setAudioSource(source);

          _isAudioSourceSet = true;
        }

        _isPlaying = true;
        _setPlayingState();
        notifyListeners();

        await audioPlayer.play();
      }
    } catch (e) {
      debugPrint("Radio error: $e");
      _setStoppedState();
    }

    _isLoading = false;
    notifyListeners();
  }

  void _setLoadingState() {
    _isLoading = true;
    _statusText = "جاري التحميل...";
    _statusTextColor = AppColors.grey;
    _buttonLabel = "انتظر...";
    _buttonIcon = Icons.hourglass_top;
  }

  void _setPlayingState() {
    _statusText = "جاري التشغيل";
    _statusTextColor = AppColors.successColor;
    _buttonLabel = "إيقاف";
    _buttonIcon = Icons.stop;
  }

  void _setStoppedState() {
    _statusText = "متوقف";
    _statusTextColor = AppColors.grey;
    _buttonLabel = "تشغيل";
    _buttonIcon = Icons.play_arrow;
  }

  @override
  Future<void> dispose() async {
    await audioPlayer.dispose();
    super.dispose();
  }
}
