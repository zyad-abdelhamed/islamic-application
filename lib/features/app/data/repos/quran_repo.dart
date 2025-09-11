import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/data/datasources/quran_local_data_source.dart';
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
              key: surahRequestParams.surahNumber.toString());
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
      return Left(ServerFailure(AppStrings.translate("unExpectedError")));
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
          surah: remoteSurahWithTafsir, key: tafsirRequestParams.surahName);
      return right(unit);
    } catch (_) {
      return left(Failure(AppStrings.translate("unExpectedError")));
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
    final ayahsList = data[0] as List<AyahEntity>;

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
}
