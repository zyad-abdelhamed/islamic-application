import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/core/errors/failures.dart';

abstract class BaseQuranRepo {
  Future<Either<Failure, List<SurahEntity>>> getPartSurahs(
      {required String part});
}
