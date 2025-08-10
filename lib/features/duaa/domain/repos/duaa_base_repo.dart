import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/duaa/domain/entities/duaa_entity.dart';

abstract class DuaaBaseRepo {
  Future<Either<Failure, List<DuaaEntity>>> getDuaaWithPegnation();
}
