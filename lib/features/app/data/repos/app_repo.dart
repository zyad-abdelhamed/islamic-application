import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/services/cache_service.dart';
import 'package:test_app/core/services/local_notifications_service.dart';
import 'package:test_app/core/services/work_manger_service.dart';
import 'package:test_app/features/app/data/datasources/daily_adhkar_local_data_source.dart';
import 'package:test_app/features/app/domain/entities/daily_adhkar_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_with_tafsir_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_app_repo.dart';
import 'package:test_app/features/app/data/datasources/location_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/prayers_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/quran_local_data_source.dart';
import 'package:test_app/features/app/domain/entities/book_mark_entity.dart';
import 'package:test_app/features/app/domain/entities/featured_record_entity.dart';
import 'package:test_app/features/app/domain/entities/location_entity.dart';
import 'package:test_app/features/app/domain/entities/prayer_sound_settings_entity.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/core/constants/data_base_constants.dart';

class AppRepoImpl extends BaseAppRepo {
  final BaseCacheService cache;
  final BaseBackgroundTasksService backgroundTasksService;
  final LocalNotificationsService notifications;

  AppRepoImpl(
      {required this.cache,
      required this.backgroundTasksService,
      required this.notifications});

  @override
  Future<Either<Failure, Unit>> resetApp() async {
    try {
      await Future.delayed(AppDurations.longDuration);

      await cache.deletecache();

      await Hive.box<DailyAdhkarEntity>(DailyAdhkarLocalDataSourceImpl.boxName)
          .clear();
      await Hive.box<FeaturedRecordEntity>(
              DataBaseConstants.featuerdRecordsHiveKey)
          .clear();
      await Hive.box<bool>(DataBaseConstants.rTableBoxHiveKey).clear();
      await Hive.box<LocationEntity>(LocationLocalDataSourceImpl.boxName)
          .clear();
      await Hive.box<Timings>(PrayersLocalDataSourceImpl.prayersBoxName)
          .clear();
      await Hive.box<PrayerSoundSettingsEntity>(
              PrayersLocalDataSourceImpl.soundSettingsBoxName)
          .clear();
      await Hive.box<BookMarkEntity>(QuranLocalDataSourceImpl.bookMarksBoxName)
          .clear();

      await Hive.box<SurahWithTafsirEntity>(
              QuranLocalDataSourceImpl.quranWithTafsirBoxName)
          .clear();

      await HydratedBloc.storage.clear();

      await backgroundTasksService.cancelAll();

      await notifications.cancelAll();

      return const Right(unit);
    } catch (_) {
      return Left(Failure(AppStrings.translate("unExpectedError")));
    }
  }
}
