import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app/app/data/datasources/home_local_data_source.dart';
import 'package:test_app/app/data/datasources/prayers_local_data_source.dart';
import 'package:test_app/app/data/datasources/prayers_remote_data_source.dart';
import 'package:test_app/app/data/datasources/records_local_data_source.dart';
import 'package:test_app/app/data/repos/home_repo.dart';
import 'package:test_app/app/data/repos/prayer_repo.dart';
import 'package:test_app/app/data/repos/records_repo.dart';
import 'package:test_app/app/domain/repositories/base_prayer_repo.dart';
import 'package:test_app/app/domain/repositories/base_records_repo.dart';
import 'package:test_app/app/domain/repositories/home_repo.dart';
import 'package:test_app/app/domain/usecases/add_record_use_case.dart';
import 'package:test_app/app/domain/usecases/delete_all_records_use_case.dart';
import 'package:test_app/app/domain/usecases/delete_records_use_case.dart';
import 'package:test_app/app/domain/usecases/get_adhkar_use_case.dart';
import 'package:test_app/app/domain/usecases/get_next_prayer_use_case.dart';
import 'package:test_app/app/domain/usecases/get_prayers_times_use_case.dart';
import 'package:test_app/app/presentation/controller/cubit/prayer_times_cubit.dart';
import 'package:test_app/app/domain/usecases/get_records_use_case.dart';
import 'package:test_app/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/app/presentation/controller/cubit/supplications_cubit.dart';
import 'package:test_app/core/services/api_services.dart';
import 'package:test_app/core/services/data_base_service.dart';
import 'package:test_app/timer/cubit/timer_cubit.dart';

GetIt sl = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    // cubits
    sl.registerFactory(() => PrayerTimesCubit(sl()));
    sl.registerFactory(() => TimerCubit());
    //usecases
    sl.registerLazySingleton(
        () => GetPrayersTimesUseCase(basePrayerRepo: sl()));
    sl.registerFactory(() => SupplicationsCubit(sl()));
    sl.registerFactory(() => FeaturedRecordsCubit(sl(), sl(), sl(), sl()));
    //usecases
    sl.registerLazySingleton<GetAdhkarUseCase>(() => GetAdhkarUseCase(sl()));
    sl.registerLazySingleton<DeleteAllRecordsUseCase>(
        () => DeleteAllRecordsUseCase(baseRecordsRepo: sl()));
    sl.registerLazySingleton<DeleteRecordsUseCase>(
        () => DeleteRecordsUseCase(sl()));
    sl.registerLazySingleton<AddRecordUseCase>(
        () => AddRecordUseCase(baseRecordsRepo: sl()));
    sl.registerLazySingleton<GetRecordsUseCase>(
        () => GetRecordsUseCase(baseRecordsRepo: sl()));
    sl.registerLazySingleton(() => GetNextPrayerUseCase(basePrayerRepo: sl()));
    //repositories
    sl.registerLazySingleton<BaseHomeRepo>(() => HomeRepo(sl()));
    sl.registerLazySingleton<BaseRecordsRepo>(
      () => RecordsRepo(recordsLocalDataSource: sl()),
    );
    sl.registerLazySingleton<BasePrayerRepo>(() => PrayerRepo(
        prayersRemoteDataSource: sl(), prayersLocalDataSource: sl()));
    // data sources
    sl.registerLazySingleton<PrayersLocalDataSource>(
        () => PrayersLocalDataSourceImpl());
    sl.registerLazySingleton<HomeLocalDataSource>(
        () => HomeLocalDataSourceImpl());
    sl.registerLazySingleton<RecordsLocalDataSource>(
      () => RecordsLocalDataSourceImpl(baseDataBaseService: sl()),
    );
    sl.registerLazySingleton<PrayersRemoteDataSource>(
        () => PrayersRemoteDataSourceImpl(sl()));

    // services
    sl.registerLazySingleton<BaseDataBaseService<int>>(
      () => HiveDatabaseService(),
    );
    sl.registerLazySingleton<ApiService>(() => ApiService(sl()));
    sl.registerLazySingleton<Dio>(() => Dio());
  }
}
