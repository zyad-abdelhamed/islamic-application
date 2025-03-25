import 'package:dartz/dartz.dart';
import 'package:test_app/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/core/errors/failures.dart';

abstract class BaseAdhkarRepo {
  Future<Either<Failure, List<AdhkarEntity>>> getAdhkar(
      {required String nameOfAdhkar});
}
