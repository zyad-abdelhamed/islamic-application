import 'package:dartz/dartz.dart';
import 'package:test_app/app/data/datasources/prayers_remote_data_source.dart';
import 'package:test_app/app/domain/entities/next_prayer_entity.dart';
import 'package:test_app/app/domain/entities/timings.dart';
import 'package:test_app/app/domain/repositories/base_prayer_repo.dart';
import 'package:test_app/core/errors/failures.dart';

class PrayerRepo extends BasePrayerRepo {
  PrayersRemoteDataSource prayersRemoteDataSource;

  PrayerRepo({required this.prayersRemoteDataSource});
  @override
  Future<Either<Failure, Timings>> getPrayerTimes() async {
    try {
      var result = await prayersRemoteDataSource.getPrayersTimes();
      return Right(result);
    } catch (e) {
      return const Left(Failure('error'));
    }
  }

  @override
  Future<Either<Failure, NextPrayerEntity>>
      getNextPrayer() async {
    try {
      NextPrayerEntity result =
          await prayersRemoteDataSource.getRemainingTimeToNextPrayer();
      return Right(result);
    } catch (e) {
      return Left(Failure('error'));
    }
  }
}
