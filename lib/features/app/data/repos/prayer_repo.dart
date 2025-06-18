import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:test_app/core/services/internet_connection.dart';
import 'package:test_app/features/app/data/datasources/prayers_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/prayers_remote_data_source.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/domain/repositories/base_prayer_repo.dart';
import 'package:test_app/core/errors/failures.dart';

class PrayerRepo extends BasePrayerRepo {
  final PrayersRemoteDataSource prayersRemoteDataSource;
  final PrayersLocalDataSource prayersLocalDataSource;
  final InternetConnection internetConnection;
  PrayerRepo(
      {required this.prayersRemoteDataSource,
      required this.internetConnection,
      required this.prayersLocalDataSource});
  @override
  Future<Either<Failure, Timings>> getPrayerTimes() async {
    try {
      Timings? timings;
      bool isConnected = await internetConnection.checkInternetConnection();

      if (isConnected) {
        try {
          timings = await prayersRemoteDataSource.getPrayersTimes();
          print('remote');
          await prayersLocalDataSource.putPrayersTimes(timings);
        } on DioException catch (_) {
          timings = await prayersLocalDataSource.getLocalPrayersTimes();
          print('local1');
          if (timings == null) {
            return Left(Failure(
                'No internet connection and no cached data available.'));
          }
        }
      } else {
        timings = await prayersLocalDataSource.getLocalPrayersTimes();
        print('local2');
        if (timings == null) {
          return Left(
              Failure('No internet connection and no cached data available.'));
        }
      }

      return Right(timings);
    } catch (e) {
      return Left(Failure('Unexpected error: $e'));
    }
  }
}
