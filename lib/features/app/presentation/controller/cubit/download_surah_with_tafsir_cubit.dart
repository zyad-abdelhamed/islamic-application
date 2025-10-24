import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';

part 'download_surah_with_tafsir_state.dart';

class DownloadSurahWithTafsirCubit extends Cubit<DownloadSurahWithTafsirState> {
  DownloadSurahWithTafsirCubit(this.baseQuranRepo)
      : super(DownloadSurahWithTafsirInitial());

  final BaseQuranRepo baseQuranRepo;

  Future<void> downloadSurahWithTafsir({
    required TafsirRequestParams tafsirRequestParams,
    required SurahRequestParams surahRequestParams,
    required List<ReciterEntity> selectedReciters,
  }) async {
    emit(DownloadSurahWithTafsirLoading());

    final Either<Failure, Unit> result =
        await baseQuranRepo.downloadSurahWithTafsir(
      tafsirRequestParams: tafsirRequestParams,
      surahRequestParams: surahRequestParams,
      selectedReciters: selectedReciters,
    );
    result.fold((l) => emit(DownloadSurahWithTafsirError(l.message)),
        (r) => emit(DownloadSurahWithTafsirSuccess()));
  }

  Future<void> deleteSurahWithTafsir({required String key}) async {
    emit(DeleteSurahWithTafsirLoading());
    final Either<Failure, Unit> result =
        await baseQuranRepo.deleteSurahWithTafsir(key: key);
    result.fold((l) => emit(DeleteSurahWithTafsirError(l.message)),
        (r) => emit(DeleteSurahWithTafsirSuccess()));
  }
}
