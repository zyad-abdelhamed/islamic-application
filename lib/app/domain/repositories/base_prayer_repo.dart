import 'package:dartz/dartz.dart';
import 'package:test_app/app/domain/entities/timings.dart';
import 'package:test_app/app/domain/usecases/get_prayers_times_use_case.dart';
import 'package:test_app/core/errors/failures.dart';

abstract class BasePrayerRepo {
  Future<Either<Failure, Timings>> getPrayerTimes({required TimingsParameters parameters});

}