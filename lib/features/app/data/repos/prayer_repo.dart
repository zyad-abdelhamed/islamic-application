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

//   @override
//   Future<Either<Failure, Timings>> getPrayerTimes() async {
//     try {
//       Timings? timings;
//       bool isConnected = await internetConnection.checkInternetConnection();

//       if (isConnected) {
//         try {
//           final result = await baseLocationRepo.getCurrentLocation();
//           result.fold((l) {return Left(Failure(l.message));},(r) async {
//             try {
//   timings = await prayersRemoteDataSource.getPrayersTimes(
//       latitude: r.latitude, longitude: r.longitude);
//       await prayersLocalDataSource.putPrayersTimes(timings!);
//             return Right(timings);
// } catch (e) {
// if (e is DioException) {
//           return left(ServerFailure.fromDiorError(e));
    
//     }
//           return Left(Failure('$e'));

//     }

//           });
//           print('remote');
//         } catch (e){
//           try {
//   timings = await prayersLocalDataSource.getLocalPrayersTimes();
//   print('local1');
//   if (timings == null) {
//        return const Left(Failure(
//         AppStrings.cachedErrorMessage));
   
//           }
//         return Right(timings!);
// } catch (e) {
//       return Left(Failure('$e'));
// }

//         }
//       } else {
//         try {
//   timings = await prayersLocalDataSource.getLocalPrayersTimes();
//   print('local2');
//   if (timings == null) {
//     return const Left(Failure(
//           AppStrings.cachedErrorMessage));
//   }
//         return Right(timings);
// }  catch (e) {
//       return Left(Failure('$e'));
// }

//       }

//     } catch (e) {
//       return Left(Failure('$e'));
//     }
//   }

  @override
  Future<Either<Failure, List<Timings>>> getPrayerTimesOfMonth(
      GetPrayerTimesOfMonthPrameters getPrayerTimesOfMonthPrameters) async {
    try {
      return right(await prayersRemoteDataSource
          .getPrayerTimesOfMonth(getPrayerTimesOfMonthPrameters));
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Timings>> getPrayerTimes() {
    // TODO: implement getPrayerTimes
    throw UnimplementedError();
  }
}
