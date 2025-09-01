import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';

abstract class BaseAppRepo {
  Future<Either<Failure, Unit>> resetApp();
}
