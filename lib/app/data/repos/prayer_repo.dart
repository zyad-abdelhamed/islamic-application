import 'package:dartz/dartz.dart';
import 'package:test_app/app/data/datasources/prayers_remote_data_source.dart';
import 'package:test_app/app/domain/entities/timings.dart';
import 'package:test_app/app/domain/repositories/base_prayer_repo.dart';
import 'package:test_app/app/domain/usecases/get_prayers_times_use_case.dart';
import 'package:test_app/core/errors/failures.dart';

class PrayerRepo extends BasePrayerRepo {
  PrayersRemoteDataSource prayersRemoteDataSource;

  PrayerRepo({required this.prayersRemoteDataSource});
  @override
  Future<Either<Failure, Timings>> getPrayerTimes(
      {required TimingsParameters parameters}) async {
    try {
      var result =
          await prayersRemoteDataSource.getPrayersTimes(parameters: parameters);
      return Right(result);
    } catch (e) {
      return const Left(Failure('error'));
    }
  }
}
