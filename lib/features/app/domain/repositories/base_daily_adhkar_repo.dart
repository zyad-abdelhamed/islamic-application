import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/domain/entities/daily_adhkar_entity.dart';

abstract class BaseDailyAdhkarRepo {
  Future<Either<Failure, Unit>> addDailyAdhkar(
      {required DailyAdhkarEntity entity});
  Future<Either<Failure, List<DailyAdhkarEntity>>> getAllDailyAdhkar();
  Future<Either<Failure, Unit>> deleteDailyAdhkar({required int index});
  Future<Either<Failure, Unit>> markedAsSeen({required int index});
}
