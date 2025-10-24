import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/data/models/quran_audio_parameters.dart';
import 'package:test_app/features/app/data/repos/quran_repo.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';

part 'download_surah_audio_state.dart';

class DownloadSurahAudioCubit extends Cubit<DownloadSurahAudioState> {
  final BaseQuranRepo _baseQuranRepo;

  DownloadSurahAudioCubit(this._baseQuranRepo)
      : super(DownloadSurahAudioInitial());

  Future<void> downloadSurah(SurahAudioRequestParams params) async {
    emit(DownloadSurahAudioLoading());

    final result = await _baseQuranRepo.downloadSurahAudio(params);

    result.fold(
      (Failure failure) =>
          emit(DownloadSurahAudioFailure(message: failure.message)),
      (SurahDownloadResult success) =>
          emit(DownloadSurahAudioSuccess(failedAyahs: success.failedAyahs)),
    );
  }

  Future<void> downloadFailedAyahs(
      SurahAudioRequestParams params, List<int> failedAyahs) async {
    emit(DownloadSurahAudioLoading());

    final Either<Failure, SurahDownloadResult> result = await _baseQuranRepo
        .downloadFailedAyahsAudio(params: params, failedAyahs: failedAyahs);

    result.fold(
      (Failure failure) =>
          emit(DownloadSurahAudioFailure(message: failure.message)),
      (SurahDownloadResult success) =>
          emit(DownloadSurahAudioSuccess(failedAyahs: success.failedAyahs)),
    );
  }

  Future<void> deleteSurahAudio(SurahAudioRequestParams params) async {
    emit(DeleteSurahAudioLoading());

    final Either<Failure, Unit> result =
        await _baseQuranRepo.deleteSurahAudio(params);

    result.fold(
      (Failure failure) =>
          emit(DeleteSurahAudioFailure(message: failure.message)),
      (_) => emit(DeleteSurahAudioSuccess()),
    );
  }
}
