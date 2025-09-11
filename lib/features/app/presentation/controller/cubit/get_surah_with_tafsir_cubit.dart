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

  late TafsirRequestParams baseTafsirRequestParams;
  late SurahRequestParams baseSurahRequestParams;

  /// لتخزين آخر عملية (تحميل أول مرة أو لود مور)
  Future<void> Function()? _lastOperation;

  Future<void> getSurahWithTafsir({
    required TafsirRequestParams tafsirRequestParams,
    required SurahRequestParams surahRequestParams,
  }) async {
    baseTafsirRequestParams = tafsirRequestParams;
    baseSurahRequestParams = surahRequestParams;

    // خزّن آخر عملية
    _lastOperation = () => getSurahWithTafsir(
          tafsirRequestParams: tafsirRequestParams,
          surahRequestParams: surahRequestParams,
        );

    final Either<Failure, SurahWithTafsirEntity> result =
        await baseRepo.getSurahWithTafsir(
      tafsirRequestParams: tafsirRequestParams,
      surahRequestParams: surahRequestParams,
    );

    result.fold(
      (failure) => emit(GetSurahWithTafsirFailure(failure.message)),
      (data) {
        _firstBatch = data;
        emit(GetSurahWithTafsirSuccess(data, hasMore: hasMore));
      },
    );
  }

  Future<void> loadMore() async {
    if (state is GetSurahWithTafsirSuccess) {
      emit((state as GetSurahWithTafsirSuccess).copyWith(isLoadingMore: true));
    }

    _currentOffset += _limit;

    // خزّن آخر عملية
    _lastOperation = loadMore;

    final Either<Failure, SurahWithTafsirEntity> result =
        await baseRepo.getSurahWithTafsir(
      tafsirRequestParams:
          baseTafsirRequestParams.copyWith(offset: _currentOffset),
      surahRequestParams:
          baseSurahRequestParams.copyWith(offset: _currentOffset),
    );

    result.fold((failure) {
      if (state is GetSurahWithTafsirSuccess) {
        // لو في بيانات قديمة، منفضلها ونعلم بس إن في error في اللود مور
        final current = state as GetSurahWithTafsirSuccess;
        emit(current.copyWith(
          isLoadingMore: false,
          loadMoreError: failure.message,
        ));
      } else {
        // لو مفيش بيانات أصلاً
        emit(GetSurahWithTafsirFailure(failure.message));
      }
    }, (newData) {
      final SurahWithTafsirEntity merged = SurahWithTafsirEntity(
        ayahsList: [
          ..._firstBatch.ayahsList,
          ...newData.ayahsList,
        ],
        allTafsir: _mergeTafsir(newData.allTafsir),
      );

      _firstBatch = merged;
      emit(GetSurahWithTafsirSuccess(
        merged,
        hasMore: hasMore,
      ));
    });
  }

  /// إعادة المحاولة لآخر عملية
  Future<void> retry() async {
    if (_lastOperation != null) {
      await _lastOperation!();
    }
  }

  // helper functions
  Map<String, List<TafsirAyahEntity>> _mergeTafsir(
      Map<String, List<TafsirAyahEntity>> newData) {
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

  bool get hasMore {
    final bool hasMore = baseSurahRequestParams.numberOfAyahs! > _currentOffset;
    return hasMore;
  }
}
