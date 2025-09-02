import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/domain/entities/book_mark_entity.dart';
import 'package:test_app/features/app/data/models/tafsir_request_params.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';

abstract class BaseQuranRepo {
  Future<Either<Failure, List<SurahEntity>>> getSurahsInfo();
  Future<Either<Failure, Unit>> saveBookMark(
      {required BookMarkEntity bookmarkentity});
  Future<Either<Failure, Unit>> clearBookMarks();
  Future<Either<Failure, Unit>> deleteBookmarksList(
      {required List<int> indexs});
  Future<Either<Failure, List<BookMarkEntity>>> getBookMarks();
  Future<Either<Failure, List<TafsirAyahEntity>>> getSurahWithTafsir(
      TafsirRequestParams params);
}
