import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/domain/entities/book_mark_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/core/errors/failures.dart';

abstract class BaseQuranRepo {
  Future<Either<Failure, List<SurahEntity>>> getPartSurahs(
      {required String part});
  Future<Either<Failure, Unit>> saveBookMark(
      {required BookMarkEntity bookmarkentity});
  Future<Either<Failure, List<BookMarkEntity>>> getBookMarks();
  Future<Either<Failure, Unit>> deleteBookMark({required int index});
  Future<Either<Failure, Unit>> clearBookMarks();
}
