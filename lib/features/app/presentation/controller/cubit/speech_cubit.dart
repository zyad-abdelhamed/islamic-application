import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/speech_to_text_service.dart';
import 'package:test_app/core/services/string_similarity.dart';

part 'speech_state.dart';

class SpeechCubit extends Cubit<SpeechState> {
  final ISpeechToTextService _speechService = sl<ISpeechToTextService>();
  final IStringSimilarityService _similarityService =
      sl<IStringSimilarityService>();

  String _spokenText = '';
  double _soundLevel = 0.0;
  bool isListening = false;

  SpeechCubit() : super(SpeechInitial());

  Future<void> initialize() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      print('🚫 Microphone permission denied');
      return;
    }

    bool available = await _speechService.initialize();
    if (available) {
      print('✅ Speech recognition initialized');
    } else {
      print('❌ Speech recognition not available');
    }
  }

  Future<void> startListening() async {
    isListening = true;
    emit(SpeechUpdated(
      spokenText: _spokenText,
      soundLevel: _soundLevel,
      isListening: true,
    ));

    await _speechService.startListening(
      onResult: (text) {
        print('🗣️ Heard: $text'); // عشان تتأكد إن بيحصل تحديث مستمر
        _spokenText = text;
        emit(SpeechUpdated(
          spokenText: _spokenText,
          soundLevel: _soundLevel,
          isListening: true,
        ));
      },
      onSoundLevelChange: (level) {
        _soundLevel = level;
        emit(SpeechUpdated(
          spokenText: _spokenText,
          soundLevel: _soundLevel,
          isListening: true,
        ));
      },
    );
  }

  void stopListening() {
    _speechService.stopListening();
    isListening = false;
    emit(SpeechUpdated(
      spokenText: _spokenText,
      soundLevel: _soundLevel,
      isListening: false,
    ));
  }

  double calculateSimilarity(String text1, String text2) {
    if (text1.isEmpty || text2.isEmpty) return 0.0;
    return _similarityService.calculateSimilarity(text1, text2);
  }
}
