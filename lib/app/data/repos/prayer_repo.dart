import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:test_app/app/data/datasources/prayers_local_data_source.dart';
import 'package:test_app/app/data/datasources/prayers_remote_data_source.dart';
import 'package:test_app/app/domain/entities/next_prayer_entity.dart';
import 'package:test_app/app/domain/entities/timings.dart';
import 'package:test_app/app/domain/repositories/base_prayer_repo.dart';
import 'package:test_app/core/errors/failures.dart';

class PrayerRepo extends BasePrayerRepo {
  PrayersRemoteDataSource prayersRemoteDataSource;
  PrayersLocalDataSource prayersLocalDataSource;
  PrayerRepo(
      {required this.prayersRemoteDataSource,
      required this.prayersLocalDataSource});
  @override
 Future<Either<Failure, Timings>> getPrayerTimes() async {
  try {
    Timings? timings;
    bool isConnected = await checkInternetConnection();

    if (isConnected) {
      try {
        timings = await prayersRemoteDataSource.getPrayersTimes();
        await prayersLocalDataSource.putPrayersTimes(timings);
      } on DioException catch (_) {
        timings = await prayersLocalDataSource.getLocalPrayersTimes();
        if (timings == null) {
          return Left(Failure('No internet connection and no cached data available.'));
        }
      }
    } else {
      timings = await prayersLocalDataSource.getLocalPrayersTimes();
      if (timings == null) {
        return Left(Failure('No internet connection and no cached data available.'));
      }
    }

    return Right(timings);
  } catch (e) {
    return Left(Failure('Unexpected error: $e'));
  }
}


  @override
  Future<Either<Failure, NextPrayerEntity>> getNextPrayer() async {
    try {
      NextPrayerEntity result =
          await prayersRemoteDataSource.getRemainingTimeToNextPrayer();
      return Right(result);
    } catch (e) {
      return Left(Failure('error'));
    }
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
