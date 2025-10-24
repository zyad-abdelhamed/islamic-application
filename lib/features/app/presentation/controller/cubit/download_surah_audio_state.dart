part of 'download_surah_audio_cubit.dart';

abstract class DownloadSurahAudioState {}

class DownloadSurahAudioInitial extends DownloadSurahAudioState {}

class DownloadSurahAudioLoading extends DownloadSurahAudioState {}

class DeleteSurahAudioLoading extends DownloadSurahAudioState {}

class DownloadSurahAudioSuccess extends DownloadSurahAudioState {
  final List<int> failedAyahs;

  DownloadSurahAudioSuccess({required this.failedAyahs});
}

class DeleteSurahAudioSuccess extends DownloadSurahAudioState {
  final String message;

  DeleteSurahAudioSuccess({this.message = 'تم الحذف بنجاح'});
}

class DownloadSurahAudioFailure extends DownloadSurahAudioState {
  final String message;

  DownloadSurahAudioFailure({required this.message});
}

class DeleteSurahAudioFailure extends DownloadSurahAudioState {
  final String message;

  DeleteSurahAudioFailure({required this.message});
}
