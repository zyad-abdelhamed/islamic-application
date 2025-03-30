import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app/app/data/datasources/prayers_remote_data_source.dart';
import 'package:test_app/app/data/repos/prayer_repo.dart';
import 'package:test_app/app/domain/repositories/base_prayer_repo.dart';
import 'package:test_app/app/domain/usecases/get_next_prayer_use_case.dart';
import 'package:test_app/app/domain/usecases/get_prayers_times_use_case.dart';
import 'package:test_app/app/presentation/controller/cubit/prayer_times_cubit.dart';
import 'package:test_app/core/services/api_services.dart';
import 'package:test_app/timer/cubit/timer_cubit.dart';

GetIt sl = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    // cubits
    sl.registerFactory(() => PrayerTimesCubit(sl()));
    sl.registerFactory(() => TimerCubit(sl()));
    //usecases
    sl.registerLazySingleton(
        () => GetPrayersTimesUseCase(basePrayerRepo: sl()));
    sl.registerLazySingleton(() => GetNextPrayerUseCase(basePrayerRepo: sl()));
    //repositories
    sl.registerLazySingleton<BasePrayerRepo>(
        () => PrayerRepo(prayersRemoteDataSource: sl()));
    // data sources
    sl.registerLazySingleton<PrayersRemoteDataSource>(
        () => PrayersRemoteDataSourceImpl(sl()));

    // services
    sl.registerLazySingleton<ApiService>(() => ApiService(sl()));
    sl.registerLazySingleton<Dio>(() => Dio());
  }
}
