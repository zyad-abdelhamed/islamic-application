import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/data/datasources/quran_local_data_source.dart';
import 'package:test_app/features/app/domain/entities/book_mark_entity.dart';
import 'package:test_app/features/app/data/datasources/quran_remote_data_source.dart';
import 'package:test_app/features/app/data/models/tafsir_request_params.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';
import 'package:test_app/core/errors/failures.dart';

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
  Future<Either<Failure, List<TafsirAyahEntity>>> getSurahWithTafsir(
      TafsirRequestParams params) async {
    try {
      final List<TafsirAyahEntity> result =
          await _baseQuranRemoteDataSource.getSurahWithTafsir(params);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return Left(ServerFailure(AppStrings.translate("unExpectedError")));
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
      print(_);
      print('///////////////');
      return left(Failure(AppStrings.translate("unExpectedError")));
    }
  }
}
