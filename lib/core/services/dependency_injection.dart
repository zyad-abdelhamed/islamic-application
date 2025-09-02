import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app/core/services/arabic_converter_service.dart';
import 'package:test_app/core/services/cache_service.dart';
import 'package:test_app/core/services/city_name_service.dart';
import 'package:test_app/core/services/image_picker_service.dart';
import 'package:test_app/core/services/internet_connection.dart';
import 'package:test_app/core/services/notifications_service.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/core/services/work_manger_service.dart';
import 'package:test_app/features/app/data/datasources/daily_adhkar_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/home_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/home_remote_data_source.dart';
import 'package:test_app/features/app/data/datasources/location_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/prayers_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/prayers_remote_data_source.dart';
import 'package:test_app/features/app/data/datasources/quran_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/quran_remote_data_source.dart';
import 'package:test_app/features/app/data/datasources/r_table_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/records_local_data_source.dart';
import 'package:test_app/features/app/data/repos/app_repo.dart';
import 'package:test_app/features/app/data/repos/daily_adhkar_repo.dart';
import 'package:test_app/features/app/data/repos/home_repo.dart';
import 'package:test_app/features/app/data/repos/location_repo.dart';
import 'package:test_app/features/app/data/repos/prayer_repo.dart';
import 'package:test_app/features/app/data/repos/qipla_repo.dart';
import 'package:test_app/features/app/data/repos/quran_repo.dart';
import 'package:test_app/features/app/data/repos/r_table_repo.dart';
import 'package:test_app/features/app/data/repos/records_repo.dart';
import 'package:test_app/features/app/domain/repositories/base_app_repo.dart';
import 'package:test_app/features/app/domain/repositories/base_daily_adhkar_repo.dart';
import 'package:test_app/features/app/domain/repositories/base_prayer_repo.dart';
import 'package:test_app/features/app/domain/repositories/base_qipla_repo.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';
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
import 'package:test_app/features/app/domain/usecases/get_surah_with_tafsir_use_case.dart';
import 'package:test_app/features/app/domain/usecases/reset_booleans_use_case.dart';
import 'package:test_app/features/app/domain/usecases/update_booleans_use_case.dart';
import 'package:test_app/features/app/presentation/controller/cubit/book_mark_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/daily_adhkar_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/location_cubit.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_adhkar_controller.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_prayer_times_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_prayer_times_of_month_cubit.dart';
import 'package:test_app/features/app/domain/usecases/get_records_use_case.dart';
import 'package:test_app/features/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayers_sound_settings_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/qibla_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/reset_app_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/rtabel_cubit.dart';
import 'package:test_app/core/services/api_services.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/duaa_cubit.dart';
import 'package:test_app/features/notifications/data/data_sources/local_data_source/daily_adhkar_notifications_local_data_source.dart';
import 'package:test_app/features/notifications/data/data_sources/local_data_source/notifications_background_tasks_local_data_source.dart';
import 'package:test_app/features/notifications/data/repos/daily_adhkar_notifications_repo_impl.dart';
import 'package:test_app/features/notifications/data/repos/notifications_background_tasks_repo_impl.dart';
import 'package:test_app/features/notifications/data/repos/prayer_times_notifications_repo_impl.dart';
import 'package:test_app/features/notifications/domain/repos/base_daily_adhkar_notifications_repo.dart';
import 'package:test_app/features/notifications/domain/repos/base_prayer_times_notifications_repo.dart';
import 'package:test_app/features/notifications/domain/repos/notifications_background_tasks_base_repo.dart';
import 'package:test_app/features/onboarding/presentation/controller/on_boarding_controller.dart';

GetIt sl = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    sl.registerLazySingleton(() => GetPrayersTimesController(
        getPrayersTimesUseCase: sl(), baseLocationRepo: sl()));
    // cubits
    sl.registerFactory(() => ResetAppCubit(sl()));
    sl.registerFactory(() => DailyAdhkarCubit(sl()));
    sl.registerFactory(() => TafsirCubit(sl()));
    sl.registerFactory(() => BookmarksCubit(sl()));
    sl.registerFactory(() => QiblaCubit(sl()));
    sl.registerFactory(() => PrayerSoundSettingsCubit(sl(), sl()));
    sl.registerFactory(() => QuranCubit(sl()));
    sl.registerFactory(() => DuaaCubit(sl()));
    sl.registerFactory(() => LocationCubit(sl()));
    sl.registerFactory(() => GetPrayerTimesOfMonthCubit(sl()));
    sl.registerFactory(() => TimerCubit());
    sl.registerFactory(() => FeaturedRecordsCubit(sl(), sl(), sl(), sl()));
    sl.registerFactory(() => RtabelCubit(sl(), sl(), sl()));
    //controllers
    sl.registerLazySingleton(() => GetAdhkarController(getAdhkarUseCase: sl()));
    sl.registerLazySingleton<OnBoardingController>(
        () => OnBoardingController());
    //usecases
    sl.registerLazySingleton(
        () => GetSurahWithTafsirUseCase(baseQuranRepo: sl()));
    sl.registerLazySingleton(
        () => GetPrayerTimesOfMonthUseCase(basePrayerRepo: sl()));
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
    sl.registerLazySingleton<BaseDailyAdhkarNotificationsRepo>(
      () => DailyAdhkarNotificationsRepoImpl(sl(), sl()),
    );
    sl.registerLazySingleton<BasePrayerTimesNotificationsRepo>(
      () => PrayerTimesNotificationsRepoImpl(sl(), sl(), sl()),
    );
    sl.registerLazySingleton<NotificationsBackgroundTasksBaseRepo>(
      () => NotificationsBackgroundTasksRepoImpl(sl(), sl(), sl(), sl()),
    );
    sl.registerLazySingleton<BaseAppRepo>(() => AppRepoImpl(
        cache: sl(), backgroundTasksService: sl(), notifications: sl()));
    sl.registerLazySingleton<BaseDailyAdhkarRepo>(
        () => DailyAdhkarRepo(localDataSource: sl()));
    sl.registerLazySingleton<BaseQiblaRepository>(() => QiblaRepository(sl()));
    sl.registerLazySingleton<BaseQuranRepo>(() => QuranRepo(sl(), sl(), sl()));
    sl.registerLazySingleton<BaseLocationRepo>(
        () => LocationRepo(sl(), sl(), sl(), sl(), sl()));
    sl.registerLazySingleton<BaseRTableRepo>(
        () => RTableRepo(rTableLocalDataSource: sl()));
    sl.registerLazySingleton<BaseHomeRepo>(() => HomeRepo(sl(), sl()));
    sl.registerLazySingleton<BaseRecordsRepo>(
      () => RecordsRepo(recordsLocalDataSource: sl()),
    );
    sl.registerLazySingleton<BasePrayerRepo>(
      () => PrayerRepo(
        prayersRemoteDataSource: sl(),
        prayersLocalDataSource: sl(),
        internetConnection: sl(),
        baseLocationRepo: sl(),
        baseLocationService: sl(),
      ),
    );
    // data sources
    sl.registerLazySingleton<BaseDailyAdhkarNotificationsLocalDataSource>(
      () => DailyAdhkarNotificationsLocalDataSourceImpl(cache: sl()),
    );
    sl.registerLazySingleton<BaseNotificationsBackgroundTasksLocalDataSource>(
      () => NotificationsBackgroundTasksLocalDataSource(cache: sl()),
    );
    sl.registerLazySingleton<BaseDailyAdhkarLocalDataSource>(
        () => DailyAdhkarLocalDataSourceImpl());
    sl.registerLazySingleton<BaseQuranRemoteDataSource>(
      () => QuranRemoteDataSource(apiService: sl()),
    );
    sl.registerLazySingleton<QuranLocalDataSource>(
      () => QuranLocalDataSourceImpl(),
    );
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
    sl.registerLazySingleton<BaseBackgroundTasksService>(
        () => BackgroundTasksServiceImplByWorkManager());
    sl.registerLazySingleton<BaseNotificationsService>(
        () => NotificationsServiceByFlutterLocalNotifications());
    sl.registerLazySingleton<BaseImagePickerService>(
        () => ImagePickerService());
    sl.registerLazySingleton<BaseCacheService>(
        () => CacheImplBySharedPreferences());
    sl.registerLazySingleton<BaseArabicConverterService>(
        () => ArabicConverterServiceImpl());
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
