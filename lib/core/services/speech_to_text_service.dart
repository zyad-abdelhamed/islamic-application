import 'package:speech_to_text/speech_to_text.dart' as stt;

abstract class ISpeechToTextService {
  Future<bool> initialize();
  Future<void> startListening(Function(String text) onResult);
  void stopListening();
  bool get isListening;
}

class SpeechToTextService implements ISpeechToTextService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  @override
  Future<bool> initialize() async {
    return await _speech.initialize(
      onError: (error) => print('Speech error: $error'),
      onStatus: (status) => print('Speech status: $status'),
    );
  }

  @override
  Future<void> startListening(Function(String text) onResult) async {
    bool available = await initialize();
    if (available) {
      _isListening = true;
      _speech.listen(
        localeId: 'ar-SA',
        onResult: (val) => onResult(val.recognizedWords),
      );
    }
  }

  @override
  void stopListening() {
    _isListening = false;
    _speech.stop();
  }

  @override
  bool get isListening => _isListening;
}
