import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app/core/services/city_name_service.dart';
import 'package:test_app/core/services/internet_connection.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/features/app/data/datasources/home_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/home_remote_data_source.dart';
import 'package:test_app/features/app/data/datasources/location_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/prayers_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/prayers_remote_data_source.dart';
import 'package:test_app/features/app/data/datasources/r_table_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/records_local_data_source.dart';
import 'package:test_app/features/app/data/repos/home_repo.dart';
import 'package:test_app/features/app/data/repos/location_repo.dart';
import 'package:test_app/features/app/data/repos/prayer_repo.dart';
import 'package:test_app/features/app/data/repos/r_table_repo.dart';
import 'package:test_app/features/app/data/repos/records_repo.dart';
import 'package:test_app/features/app/domain/repositories/base_prayer_repo.dart';
import 'package:test_app/features/app/domain/repositories/base_records_repo.dart';
import 'package:test_app/features/app/domain/repositories/home_repo.dart';
import 'package:test_app/features/app/domain/repositories/location_repo.dart';
import 'package:test_app/features/app/domain/repositories/r_table_repo.dart';
import 'package:test_app/features/app/domain/usecases/add_record_use_case.dart';
import 'package:test_app/features/app/domain/usecases/delete_all_records_use_case.dart';
import 'package:test_app/features/app/domain/usecases/delete_records_use_case.dart';
import 'package:test_app/features/app/domain/usecases/get_adhkar_use_case.dart';
import 'package:test_app/features/app/domain/usecases/get_booleans_use_case.dart';
import 'package:test_app/features/app/domain/usecases/get_prayer_times_of_month_use_case.dart';
import 'package:test_app/features/app/domain/usecases/get_prayers_times_use_case.dart';
import 'package:test_app/features/app/domain/usecases/get_today_hadith_use_case.dart';
import 'package:test_app/features/app/domain/usecases/reset_booleans_use_case.dart';
import 'package:test_app/features/app/domain/usecases/update_booleans_use_case.dart';
import 'package:test_app/features/app/presentation/controller/controllers/cubit/location_cubit.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_adhkar_controller.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_prayer_times_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_prayer_times_of_month_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/hadith_cubit.dart';
import 'package:test_app/features/app/domain/usecases/get_records_use_case.dart';
import 'package:test_app/features/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayer_times_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/rtabel_cubit.dart';
import 'package:test_app/core/services/api_services.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_cubit.dart';
import 'package:test_app/features/duaa/data/dataSource/duaa_local_data_source.dart';
import 'package:test_app/features/duaa/data/repos/duaa_repo.dart';
import 'package:test_app/features/duaa/domain/repos/duaa_base_repo.dart';
import 'package:test_app/features/duaa/presentation/controllers/cubit/duaa_cubit.dart';
import 'package:test_app/features/onboarding/presentation/controller/on_boarding_cubit.dart';

GetIt sl = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    sl.registerLazySingleton(
        () => GetPrayersTimesController(getPrayersTimesUseCase: sl(),baseLocationRepo: sl()));
    // cubits
    sl.registerFactory(() => DuaaCubit(sl()));
    sl.registerFactory(()=> LocationCubit(sl()));
    sl.registerLazySingleton(() => OnBoardingCubit());
    sl.registerFactory(() => GetPrayerTimesOfMonthCubit(sl()));
    sl.registerFactory(() => TimerCubit());
    sl.registerFactory(() => PrayerTimesCubit(sl()));
    sl.registerFactory(() => HadithCubit(sl()));
    sl.registerFactory(() => FeaturedRecordsCubit(sl(), sl(), sl(), sl()));
    sl.registerFactory(() => RtabelCubit(sl(), sl(), sl()));
    //controllers
    sl.registerLazySingleton(() => GetAdhkarController(getAdhkarUseCase: sl()));
    //usecases
    sl.registerLazySingleton(
        () => GetPrayerTimesOfMonthUseCase(basePrayerRepo: sl()));
    sl.registerLazySingleton(() => GetTodayHadithUseCase(baseHomeRepo: sl()));
    sl.registerLazySingleton(
        () => GetPrayersTimesUseCase(basePrayerRepo: sl()));
    sl.registerLazySingleton(() => GetBooleansUseCase(sl()));
    sl.registerLazySingleton(() => ResetBooleansUseCase(sl()));
    sl.registerLazySingleton(() => UpdateBooleansUseCase(sl()));

    sl.registerLazySingleton<GetAdhkarUseCase>(() => GetAdhkarUseCase(sl()));
    sl.registerLazySingleton<DeleteAllRecordsUseCase>(
        () => DeleteAllRecordsUseCase(baseRecordsRepo: sl()));
    sl.registerLazySingleton<DeleteRecordsUseCase>(
        () => DeleteRecordsUseCase(sl()));
    sl.registerLazySingleton<AddRecordUseCase>(
        () => AddRecordUseCase(baseRecordsRepo: sl()));
    sl.registerLazySingleton<GetRecordsUseCase>(
        () => GetRecordsUseCase(baseRecordsRepo: sl()));
    //repositories
    sl.registerLazySingleton<BaseLocationRepo>(() => LocationRepo(sl(),sl(),sl(),sl()));
    sl.registerLazySingleton<DuaaBaseRepo>(() => DuaaRepo(sl()));
    sl.registerLazySingleton<BaseRTableRepo>(
        () => RTableRepo(rTableLocalDataSource: sl()));
    sl.registerLazySingleton<BaseHomeRepo>(() => HomeRepo(sl(), sl()));
    sl.registerLazySingleton<BaseRecordsRepo>(
      () => RecordsRepo(recordsLocalDataSource: sl()),
    );
    sl.registerLazySingleton<BasePrayerRepo>(() => PrayerRepo(
        prayersRemoteDataSource: sl(),
        prayersLocalDataSource: sl(),
        internetConnection: sl<InternetConnection>(),
        baseLocationRepo: sl<BaseLocationRepo>()));
    // data sources
    sl.registerLazySingleton<DuaaLocalDataSource>(
        () => DuaaLocalDataSourceImpl());
    sl.registerLazySingleton<BaseLocationLocalDataSource>(
        () => LocationLocalDataSourceImpl());
    sl.registerLazySingleton<BaseHomeRemoteDataSource>(
        () => HomeRemoteDataSource(apiService: sl()));
    sl.registerLazySingleton<RTableLocalDataSource>(
        () => RTableLocalDataSourceImpl());
    sl.registerLazySingleton<PrayersLocalDataSource>(
        () => PrayersLocalDataSourceImpl());
    sl.registerLazySingleton<HomeLocalDataSource>(
        () => HomeLocalDataSourceImpl());
    sl.registerLazySingleton<RecordsLocalDataSource>(
      () => RecordsLocalDataSourceImpl(),
    );
    sl.registerLazySingleton<PrayersRemoteDataSource>(
        () => PrayersRemoteDataSourceImpl(sl()));

    // services
    sl.registerLazySingleton<LocationNameService>(
        () => LocationNameServiceImpl());
    sl.registerSingleton<BaseLocationService>(
        LocatationServiceImplByGeolocator());
    sl.registerLazySingleton<InternetConnection>(
        () => InternetConnectionImpl2());
    sl.registerLazySingleton<ApiService>(() => ApiService(sl()));
    sl.registerLazySingleton<Dio>(() => Dio());
  }
}
