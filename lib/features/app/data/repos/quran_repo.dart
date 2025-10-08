import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/data/datasources/quran_local_data_source.dart';
import 'package:test_app/features/app/domain/entities/ayah_search_result_entity.dart';
import 'package:test_app/features/app/domain/entities/book_mark_entity.dart';
import 'package:test_app/features/app/data/datasources/quran_remote_data_source.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/domain/entities/ayah_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_with_tafsir_entity.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/helper_function/get_from_json.dart';
import 'package:test_app/features/app/data/models/tafsir_edition_model.dart';
import 'package:test_app/features/app/domain/entities/tafsir_edition_entity.dart';

class QuranRepo implements BaseQuranRepo {
  final QuranLocalDataSource _quranLocalDataSource;
  final BaseQuranRemoteDataSource _baseQuranRemoteDataSource;
  final QuranLocalDataSource quranLocalDataSource;

  QuranRepo(
    this._baseQuranRemoteDataSource,
    this._quranLocalDataSource,
    this.quranLocalDataSource,
  );

  @override
  Future<Either<Failure, SurahWithTafsirEntity>> getSurahWithTafsir(
      {required TafsirRequestParams tafsirRequestParams,
      required SurahRequestParams surahRequestParams}) async {
    try {
      final SurahWithTafsirEntity? cachedSurahWithTafsir =
          await _quranLocalDataSource.getSurahWithTafsir(
              key: tafsirRequestParams.surah.name);

      if (cachedSurahWithTafsir != null) {
        return Right(cachedSurahWithTafsir);
      }

      final SurahWithTafsirEntity remoteSurahWithTafsir =
          await _getSurahWithTafsirFromRemoteDataSoruce(
              tafsirRequestParams, surahRequestParams);
      return Right(remoteSurahWithTafsir);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      print("❌ getSurahWithTafsir error: $e");
      return Left(ServerFailure(AppStrings.translate(e.toString())));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteSurahWithTafsir(
      {required String key}) async {
    try {
      await _quranLocalDataSource.deleteSurahWithTafsir(key: key);
      return right(unit);
    } catch (_) {
      return left(Failure(AppStrings.translate("unExpectedError")));
    }
  }

  @override
  Future<Either<Failure, Unit>> downloadSurahWithTafsir(
      {required TafsirRequestParams tafsirRequestParams,
      required SurahRequestParams surahRequestParams}) async {
    try {
      final SurahWithTafsirEntity remoteSurahWithTafsir =
          await _getSurahWithTafsirFromRemoteDataSoruce(
              tafsirRequestParams, surahRequestParams);
      await _quranLocalDataSource.saveSurahWithTafsir(
          surah: remoteSurahWithTafsir, key: tafsirRequestParams.surah.name);
      return right(unit);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return Left(ServerFailure(AppStrings.translate(e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<BookMarkEntity>>> getBookMarks() async {
    try {
      final result = await quranLocalDataSource.getBookMarks();
      return right(result);
    } catch (e) {
      return left(Failure('خطأ فى تحميل العلامات'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveBookMark(
      {required BookMarkEntity bookmarkentity}) async {
    try {
      await quranLocalDataSource.saveBookMark(bookmarkentity: bookmarkentity);
      return right(unit);
    } catch (e) {
      return left(Failure('خطأ ف حفظ العلامة'));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearBookMarks() async {
    try {
      await quranLocalDataSource.clearBookMarks();
      return right(unit);
    } catch (e) {
      return left(Failure('خطأ ف مسح العلامات'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteBookmarksList(
      {required List<int> indexs}) async {
    try {
      await quranLocalDataSource.deleteBookmarksList(indexes: indexs);
      return right(unit);
    } catch (e) {
      return left(Failure('خطأ في مسح العلامة'));
    }
  }

  @override
  Future<Either<Failure, List<SurahEntity>>> getSurahsInfo() async {
    try {
      final List<SurahEntity> surahsInfo =
          await _quranLocalDataSource.getSurahsInfo();
      return right(surahsInfo);
    } catch (_) {
      return left(Failure(AppStrings.translate("unExpectedError")));
    }
  }

  @override
  Future<Either<Failure, SearchAyahWithTafsirEntity>> search(
    String query,
  ) async {
    try {
      // 1) Call remote data source للبحث عن الآيات
      final AyahSearchResultEntity searchResult =
          await _baseQuranRemoteDataSource.searchInQuran(query);

      if (searchResult.count == 0) {
        return left(Failure("لا يوجد نتائج للبحث"));
      }

      // 2) Load tafsir editions
      final List<TafsirEditionEntity> tafsirEditions =
          await loadTafsirEditions();

      // 3) جهز كل الريكوستات (ayah tafsir لكل edition) مع retry
      final List<Future<TafsirAyahEntity>> allRequests = [];

      for (final ayah in searchResult.ayahs) {
        for (final edition in tafsirEditions) {
          allRequests.add(
            _safeGetAyahTafsir(
              ayah.number,
              edition.identifier,
            ),
          );
        }
      }

      List<TafsirAyahEntity> responses;

      try {
        // 4) جرّب كلهم مرّة واحدة
        responses = await Future.wait(allRequests);
        print("✅ responses length: ${responses.length}");
      } on DioException catch (e) {
        // لو حصل overload أو rate-limit (مثلاً 429 أو 503)
        if (e.response?.statusCode == 429 || e.response?.statusCode == 503) {
          responses = await _runInBatches(allRequests, batchSize: 20);
        } else {
          return Left(ServerFailure.fromDiorError(e));
        }
      }

      // 5) رتب الناتج النهائي: لكل مفسر → List<TafsirAyahEntity>
      final Map<String, List<TafsirAyahEntity>> ayahsAllTafsir = {};

      for (int i = 0; i < searchResult.ayahs.length; i++) {
        for (int j = 0; j < tafsirEditions.length; j++) {
          final edition = tafsirEditions[j];
          final index = i * tafsirEditions.length + j;

          final TafsirAyahEntity tafsirEntity = responses[index];

          ayahsAllTafsir.putIfAbsent(edition.name, () => []);
          ayahsAllTafsir[edition.name]!.add(tafsirEntity);
        }
      }

      // 6) بناء الـ Entity النهائي
      final SearchAyahWithTafsirEntity entity = SearchAyahWithTafsirEntity(
        ayahsAllTafsir: ayahsAllTafsir,
        ayahSearchResultEntity: searchResult,
      );

      return right(entity);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      print("❌ Unhandled error: $e");
      return Left(Failure(e.toString()));
    }
  }

  /// Safe tafsir fetch with retry + fallback
  Future<TafsirAyahEntity> _safeGetAyahTafsir(
    int ayahNumber,
    String edition, {
    int retries = 3,
  }) async {
    int attempt = 0;

    while (attempt < retries) {
      try {
        final tafsir = await _baseQuranRemoteDataSource.getAyahTafsir(
          ayahNumber,
          edition,
        );
        return tafsir;
      } catch (e) {
        attempt++;
        print(
            "⚠️ Attempt $attempt failed for ayah=$ayahNumber, edition=$edition, error=$e");

        if (attempt >= retries) {
          return const TafsirAyahEntity(
            text: "لا يوجد تفسير متاح لهذه الآية",
          );
        }

        // delay قبل المحاولة التالية
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }

    return const TafsirAyahEntity(
      text: "لا يوجد تفسير متاح لهذه الآية",
    );
  }

  // helper functions
  Future<SurahWithTafsirEntity> _getSurahWithTafsirFromRemoteDataSoruce(
    TafsirRequestParams tafsirRequestParams,
    SurahRequestParams surahRequestParams,
  ) async {
    final List<TafsirEditionEntity> tafsirEditions = await loadTafsirEditions();

    final List data = await Future.wait([
      _baseQuranRemoteDataSource.getAyahs(surahRequestParams),
      ...List.generate(
        tafsirEditions.length,
        (i) => _baseQuranRemoteDataSource.getTafsirAyahs(
          tafsirRequestParams.copyWith(
            edition: tafsirEditions[i].identifier,
          ),
        ),
      ),
    ]);

// الآيات
    final List<AyahEntity> ayahsList = data[0] as List<AyahEntity>;

// باقي العناصر = تفاسير كل Edition بالترتيب
    final tafsirResults = data.sublist(1);

// بناء الـ Map: name → List<TafsirAyahEntity>
    final Map<String, List<TafsirAyahEntity>> allTafsir = {};

    for (int i = 0; i < tafsirEditions.length; i++) {
      final edition = tafsirEditions[i];
      final tafsirAyahs = tafsirResults[i] as List<TafsirAyahEntity>;

      allTafsir[edition.name] = tafsirAyahs;
    }

// الناتج النهائي
    final SurahWithTafsirEntity surahWithTafsir = SurahWithTafsirEntity(
      ayahsList: ayahsList,
      allTafsir: allTafsir,
    );

    return surahWithTafsir;
  }

  Future<List<TafsirEditionEntity>> loadTafsirEditions() async {
    final List data = await getJson(RoutesConstants.tafsirJsonRouteName);

    return data.map((map) => TafsirEditionModel.fromJson(map)).toList();
  }

  Future<List<TafsirAyahEntity>> _runInBatches(
    List<Future<TafsirAyahEntity>> requests, {
    int batchSize = 20,
  }) async {
    final List<TafsirAyahEntity> results = [];

    for (var i = 0; i < requests.length; i += batchSize) {
      final batch = requests.skip(i).take(batchSize);
      final batchResults = await Future.wait(batch);
      results.addAll(batchResults as Iterable<TafsirAyahEntity>);
    }

    return results;
  }
}
