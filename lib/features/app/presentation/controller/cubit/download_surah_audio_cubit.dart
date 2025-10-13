import 'package:bloc/bloc.dart';
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
}
