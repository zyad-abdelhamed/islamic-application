part of 'speech_cubit.dart';

abstract class SpeechState {}

class SpeechInitial extends SpeechState {}

class GetAyahsLoading extends SpeechState {}

class GetAyahsSuccess extends SpeechState {
  final List<AyahEntity> ayahs;
  GetAyahsSuccess(this.ayahs);
}

class GetAyahsFailure extends SpeechState {
  final String failure;
  GetAyahsFailure(this.failure);
}

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
