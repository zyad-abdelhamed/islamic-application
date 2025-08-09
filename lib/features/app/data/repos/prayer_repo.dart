import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/internet_connection.dart';
import 'package:test_app/features/app/data/datasources/prayers_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/prayers_remote_data_source.dart';
import 'package:test_app/features/app/data/models/get_prayer_times_of_month_prameters.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/domain/repositories/base_prayer_repo.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/domain/repositories/location_repo.dart';

class PrayerRepo extends BasePrayerRepo {
  final PrayersRemoteDataSource prayersRemoteDataSource;
  final PrayersLocalDataSource prayersLocalDataSource;
  final InternetConnection internetConnection;
  final BaseLocationRepo baseLocationRepo;
  PrayerRepo({
    required this.prayersRemoteDataSource,
    required this.internetConnection,
    required this.prayersLocalDataSource,
    required this.baseLocationRepo,
  });

  @override
  Future<Either<Failure, Timings>> getPrayerTimes() async {
    try {
      final isConnected = await internetConnection.checkInternetConnection();

      if (isConnected) {
        final locationResult = await baseLocationRepo.getCurrentLocation();

        return await locationResult.fold<Future<Either<Failure, Timings>>>(
          (failure) async => await _getLocalTimingsWithFallbackOrReturnOriginal(
              Failure(failure.message)),
          (location) async {
            try {
              final timings = await prayersRemoteDataSource.getPrayersTimes(
                latitude: location.latitude,
                longitude: location.longitude,
              );

              await prayersLocalDataSource.putPrayersTimes(timings);
              return Right(timings);
            } on DioException catch (dioError) {
              return await _getLocalTimingsWithFallbackOrReturnOriginal(
                ServerFailure.fromDiorError(dioError),
              );
            } catch (e) {
              return await _getLocalTimingsWithFallbackOrReturnOriginal(
                  Failure('$e'));
            }
          },
        );
      } else {
        return await _getLocalTimingsFallback(); // no internet, return cached only
      }
    } catch (e) {
      return Left(Failure('$e'));
    }
  }

  Future<Either<Failure, Timings>> _getLocalTimingsWithFallbackOrReturnOriginal(
      Failure originalFailure) async {
    try {
      final timings = await prayersLocalDataSource.getLocalPrayersTimes();
      if (timings != null) {
        return Right(timings);
      } else {
        return Left(originalFailure); // نرجع الخطأ الأصلي
      }
    } catch (e) {
      return Left(Failure('$e'));
    }
  }

  Future<Either<Failure, Timings>> _getLocalTimingsFallback() async {
    try {
      final timings = await prayersLocalDataSource.getLocalPrayersTimes();
      if (timings == null) {
        return const Left(Failure(AppStrings.cachedErrorMessage));
      }
      return Right(timings);
    } catch (e) {
      return Left(Failure('$e'));
    }
  }

  @override
  Future<Either<Failure, List<Timings>>> getPrayerTimesOfMonth(
      GetPrayerTimesOfMonthPrameters getPrayerTimesOfMonthPrameters) async {
    final locationResult = await baseLocationRepo.getCurrentLocation();

    return await locationResult.fold<Future<Either<Failure, List<Timings>>>>(
      (failure) async => Left(Failure(failure.message)),
      (r) async {
        final List<Timings> timingsOfMonth = await prayersRemoteDataSource
            .getPrayerTimesOfMonth(getPrayerTimesOfMonthPrameters,
                latitude: r.latitude, longitude: r.longitude);
        return Right(timingsOfMonth);
      },
    );
  }
}
