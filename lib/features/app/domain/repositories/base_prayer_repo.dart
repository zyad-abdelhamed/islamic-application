import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/domain/entities/next_prayer_entity.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/core/errors/failures.dart';

abstract class BasePrayerRepo {
  Future<Either<Failure, Timings>> getPrayerTimes(
      );
  Future<Either<Failure, NextPrayerEntity>> getNextPrayer(
      );
}
