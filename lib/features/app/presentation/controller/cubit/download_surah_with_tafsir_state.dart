part of 'download_surah_with_tafsir_cubit.dart';

sealed class DownloadSurahWithTafsirState extends Equatable {
  const DownloadSurahWithTafsirState();

  @override
  List<Object> get props => [];
}

final class DownloadSurahWithTafsirInitial
    extends DownloadSurahWithTafsirState {}

final class DownloadSurahWithTafsirLoading
    extends DownloadSurahWithTafsirState {}

final class DownloadSurahWithTafsirSuccess
    extends DownloadSurahWithTafsirState {}

final class DownloadSurahWithTafsirError extends DownloadSurahWithTafsirState {
  final String message;
  const DownloadSurahWithTafsirError(this.message);

  @override
  List<Object> get props => [message];
}

final class DeleteSurahWithTafsirLoading extends DownloadSurahWithTafsirState {}

final class DeleteSurahWithTafsirSuccess extends DownloadSurahWithTafsirState {}

final class DeleteSurahWithTafsirError extends DownloadSurahWithTafsirState {
  final String message;
  const DeleteSurahWithTafsirError(this.message);

  @override
  List<Object> get props => [message];
}
