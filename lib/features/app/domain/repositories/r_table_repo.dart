import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/models/booleans_model.dart';

abstract class BaseRTableRepo {
  Future<Either<Failure, List<bool>>> getBooleans();
  Future<Either<Failure, Unit>> updateBooleans(
      {required BooleansParameters parameters});
  Future<Either<Failure, Unit>> resetBooleans();
}
