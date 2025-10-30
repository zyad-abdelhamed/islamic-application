import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';
import 'package:test_app/features/app/domain/entities/ayah_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_with_tafsir_entity.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';

import 'get_surah_with_tafsir_state.dart';

class GetSurahWithTafsirCubit extends Cubit<GetSurahWithTafsirState> {
  final BaseQuranRepo baseRepo;

  GetSurahWithTafsirCubit(this.baseRepo) : super(GetSurahWithTafsirInitial());

  late SurahWithTafsirEntity _firstBatch;
  int _currentOffset = 0;
  final int _limit = 10;
  int numOfCurrentAyahs = 0;

  late TafsirRequestParams baseTafsirRequestParams;
  late SurahRequestParams baseSurahRequestParams;

  /// لتخزين آخر عملية (تحميل أول مرة أو لود مور)
  Future<void> Function()? _lastOperation;

  Future<void> getSurahWithTafsir({
    required TafsirRequestParams tafsirRequestParams,
    required SurahRequestParams surahRequestParams,
  }) async {
    emit(GetSurahWithTafsirLoading());

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
      (failure) {
        if (!isClosed) {
          emit(GetSurahWithTafsirFailure(failure.message));
        }
      },
      (data) {
        _icreaseNumOfCurrentAyahs(data.ayahsList.length);

        _firstBatch = data;
        if (!isClosed) {
          emit(GetSurahWithTafsirSuccess(data, hasMore: hasMore));
        }
      },
    );
  }

  Future<void> loadMore() async {
    emit((state as GetSurahWithTafsirSuccess)
        .copyWith(isLoadingMore: true, hasMore: false));

    // خزّن آخر عملية
    _lastOperation = loadMore;

    _currentOffset += _limit;
    final Either<Failure, SurahWithTafsirEntity> result =
        await baseRepo.getSurahWithTafsir(
      tafsirRequestParams:
          baseTafsirRequestParams.copyWith(offset: _currentOffset),
      surahRequestParams:
          baseSurahRequestParams.copyWith(offset: _currentOffset),
    );

    result.fold((failure) {
      _currentOffset -= _limit;

      if (!isClosed) {
        if (state is GetSurahWithTafsirSuccess) {
          // لو في بيانات قديمة، منفضلها ونعلم بس إن في error في اللود مور
          final GetSurahWithTafsirSuccess current =
              state as GetSurahWithTafsirSuccess;
          emit(current.copyWith(
            isLoadingMore: false,
            loadMoreError: failure.message,
          ));
        } else {
          // لو مفيش بيانات أصلاً
          emit(GetSurahWithTafsirFailure(failure.message));
        }
      }
    }, (newData) {
      if (!isClosed) {
        _icreaseNumOfCurrentAyahs(newData.ayahsList.length);
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
      }
    });
  }

  /// إعادة المحاولة لآخر عملية
  Future<void> retry() async {
    if (_lastOperation != null) {
      await _lastOperation!();
    }
  }

  void search(String query) {
    final normalizedQuery = normalizeArabic(query);

    final Map<String, dynamic> filtered =
        _firstBatch.ayahsList.asMap().entries.fold<Map<String, dynamic>>(
      {
        'ayahs': <AyahEntity>[],
        'tafsir': <String, List<TafsirAyahEntity>>{},
      },
      (acc, entry) {
        final int index = entry.key;
        final AyahEntity ayah = entry.value;

        final normalizedAyah = normalizeArabic(ayah.text);

        if (normalizedAyah.contains(normalizedQuery)) {
          acc['ayahs']!.add(ayah);

          _firstBatch.allTafsir.forEach((mufassir, tafsirList) {
            acc['tafsir']!.putIfAbsent(mufassir, () => <TafsirAyahEntity>[]);
            if (index < tafsirList.length) {
              acc['tafsir']![mufassir]!.add(tafsirList[index]);
            }
          });
        }

        return acc;
      },
    );

    if ((filtered['ayahs'] as List<AyahEntity>).isEmpty) {
      emit(GetSurahWithTafsirSearchNotFoundDataState());
      return;
    }

    emit(GetSurahWithTafsirSearchState(
      ayahs: filtered['ayahs'] as List<AyahEntity>,
      tafsirAyahs: filtered['tafsir'] as Map<String, List<TafsirAyahEntity>>,
    ));
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

  /// يشيل كل التشكيل والرموز الغير أساسية من النص القرآني
  String normalizeArabic(String input) {
    final RegExp diacritics = RegExp(r'[\u064B-\u0652\u0670\u0651-\u0653]');
    final RegExp quranSymbols = RegExp(r'[\u06D6-\u06ED]');
    final RegExp tatweel = RegExp(r'[\u0640]'); // ـ (الكشيدة)

    return input
        .replaceAll(diacritics, '')
        .replaceAll(quranSymbols, '')
        .replaceAll(tatweel, '')
        .trim();
  }

  void _icreaseNumOfCurrentAyahs(int value) {
    numOfCurrentAyahs += value;
  }

  bool get hasMore {
    final bool hasMore =
        baseSurahRequestParams.surah.numberOfAyat > numOfCurrentAyahs;
    return hasMore;
  }
}
