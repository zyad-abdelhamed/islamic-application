import 'package:speech_to_text/speech_to_text.dart' as stt;

abstract class ISpeechToTextService {
  Future<bool> initialize();
  Future<void> startListening({
    required Function(String text) onResult,
    required Function(double level) onSoundLevelChange,
  });
  Future<void> stopListening();
}

class SpeechToTextService implements ISpeechToTextService {
  final stt.SpeechToText _speech = stt.SpeechToText();

  @override
  Future<bool> initialize() async {
    return await _speech.initialize(
      onStatus: (status) {
        print('🎙️ Speech status: $status');
      },
      onError: (error) {
        print('❌ Speech error: $error');
      },
    );
  }

  @override
  Future<void> startListening({
    required Function(String text) onResult,
    required Function(double level) onSoundLevelChange,
  }) async {
    await _speech.listen(
      onResult: (result) {
        print('🟢 Partial result: ${result.recognizedWords}');
        onResult(result.recognizedWords);
      },
      localeId: 'ar-EG', // ✅ مهم علشان العربية

      listenMode: stt.ListenMode.dictation,
      partialResults: true, // ✅ مهم جدًا
      onSoundLevelChange: (level) => onSoundLevelChange(level),
      cancelOnError: false,
      listenFor: const Duration(minutes: 60),
      pauseFor: const Duration(minutes: 3),
    );
  }

  @override
  Future<void> stopListening() async {
    await _speech.stop();
  }
}
