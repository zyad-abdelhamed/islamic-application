import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';
import 'package:test_app/features/app/domain/entities/surah_with_tafsir_entity.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';

import 'get_surah_with_tafsir_state.dart';

class GetSurahWithTafsirCubit extends Cubit<GetSurahWithTafsirState> {
  final BaseQuranRepo baseRepo;

  GetSurahWithTafsirCubit(this.baseRepo) : super(GetSurahWithTafsirLoading());

  late SurahWithTafsirEntity _firstBatch;
  int _currentOffset = 0;
  final int _limit = 10;
  bool _hasMore = true;

  late final TafsirRequestParams baseTafsirRequestParams;
  late final SurahRequestParams baseSurahRequestParams;

  Future<void> getSurahWithTafsir({
    required TafsirRequestParams tafsirRequestParams,
    required SurahRequestParams surahRequestParams,
  }) async {
    baseTafsirRequestParams = tafsirRequestParams;
    baseSurahRequestParams = surahRequestParams;

    final Either<Failure, SurahWithTafsirEntity> result =
        await baseRepo.getSurahWithTafsir(
      tafsirRequestParams: tafsirRequestParams,
      surahRequestParams: surahRequestParams,
    );

    result.fold(
      (failure) => emit(GetSurahWithTafsirFailure(failure.message)),
      (data) {
        _firstBatch = data;
        emit(GetSurahWithTafsirSuccess(data));
      },
    );
  }

  Future<void> loadMore() async {
    if (!_hasMore) {
      emit(GetSurahWithTafsirNoMoreData());
      return;
    }

    emit(GetSurahWithTafsirLoadingMore());

    _currentOffset += _limit;

    final Either<Failure, SurahWithTafsirEntity> result =
        await baseRepo.getSurahWithTafsir(
      tafsirRequestParams:
          baseTafsirRequestParams.copyWith(offset: _currentOffset),
      surahRequestParams:
          baseSurahRequestParams.copyWith(offset: _currentOffset),
    );

    result.fold(
      (failure) => emit(GetSurahWithTafsirFailure(failure.message)),
      (newData) {
        if (newData.ayahsList.isEmpty && newData.allTafsir.isEmpty) {
          _hasMore = false;
          emit(GetSurahWithTafsirNoMoreData());
        } else {
          final SurahWithTafsirEntity merged = SurahWithTafsirEntity(
            ayahsList: [
              ..._firstBatch.ayahsList,
              ...newData.ayahsList,
            ],
            allTafsir: _mergeTafsir(newData.allTafsir),
          );

          _firstBatch = merged;
          emit(GetSurahWithTafsirSuccess(merged));
        }
      },
    );
  }

  // helper functions
  Map<String, List<TafsirAyahEntity>> _mergeTafsir(
      Map<String, List<TafsirAyahEntity>> newData) {
    // دمج البيانات القديمة والجديدة
    final Map<String, List<TafsirAyahEntity>> mergedTafsir =
        <String, List<TafsirAyahEntity>>{};

    // القديم
    _firstBatch.allTafsir.forEach((mufassir, tafsirList) {
      mergedTafsir[mufassir] = List.from(tafsirList);
    });

    // الجديد
    newData.forEach((mufassir, tafsirList) {
      if (mergedTafsir.containsKey(mufassir)) {
        mergedTafsir[mufassir]!.addAll(tafsirList);
      } else {
        mergedTafsir[mufassir] = List.from(tafsirList);
      }
    });

    return mergedTafsir;
  }
}
