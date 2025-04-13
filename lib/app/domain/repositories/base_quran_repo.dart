import 'package:dartz/dartz.dart';
import 'package:test_app/app/domain/entities/quran_entity.dart';
import 'package:test_app/core/errors/failures.dart';

abstract class BaseQuranRepo {
  Future<Either<Failure, List<QuranEntity>>> getInfoQuran(
      {required String part});
}
