part of 'speech_cubit.dart';

abstract class SpeechState {}

class SpeechInitial extends SpeechState {}

class SpeechUpdated extends SpeechState {
  final String spokenText;
  final double soundLevel;
  final bool isListening;

  SpeechUpdated({
    required this.spokenText,
    required this.soundLevel,
    required this.isListening,
  });
}
