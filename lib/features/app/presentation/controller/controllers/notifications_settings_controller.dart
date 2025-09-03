import 'package:flutter/material.dart';
import 'package:test_app/core/constants/cache_constants.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/cache_service.dart';
import 'package:test_app/features/app/presentation/controller/controllers/settings_page_controller.dart';
import 'package:test_app/features/notifications/data/repos/notifications_background_tasks_repo_impl.dart';
import 'package:test_app/features/notifications/domain/repos/base_daily_adhkar_notifications_repo.dart';
import 'package:test_app/features/notifications/domain/repos/base_prayer_times_notifications_repo.dart';

class NotificationsSettingsController {
  late final ValueNotifier<bool> isPrayerEnabled;
  late final ValueNotifier<bool> isAdhkarEnabled;
  late final ValueNotifier<SettingsPageState> settingsPageState;
  late final BaseCacheService _cache;
  late final BasePrayerTimesNotificationsRepo prayerTimesNotificationsRepo;
  late final BaseDailyAdhkarNotificationsRepo dailyAdhkarNotificationsRepo;

  NotificationsSettingsController(ValueNotifier<SettingsPageState> pageState) {
    _cache = sl<BaseCacheService>();
    // قراءة القيم من الكاش عند بدء الصفحة
    isPrayerEnabled = ValueNotifier<bool>(!(_cache.getboolFromCache(
            key: CacheConstants.isPrayerTimesNotRegisteredInWorkManger) ??
        true));
    isAdhkarEnabled = ValueNotifier<bool>(!(_cache.getboolFromCache(
            key: CacheConstants.isDailyAdhkarNotRegisteredInWorkManger) ??
        true));

    prayerTimesNotificationsRepo = sl<BasePrayerTimesNotificationsRepo>();
    dailyAdhkarNotificationsRepo = sl<BaseDailyAdhkarNotificationsRepo>();

    settingsPageState = pageState;
  }

  void dispose() {
    isPrayerEnabled.dispose();
    isAdhkarEnabled.dispose();
  }

  Future<void> togglePrayer() async {
    settingsPageState.value = SettingsPageState.loading;
    final bool value = _cache.getboolFromCache(
            key: CacheConstants.isPrayerTimesNotRegisteredInWorkManger) ??
        true;
    if (value) {
      await prayerTimesNotificationsRepo.rescheduleRemainingPrayers();
      await NotificationsBackgroundTasksRepoImpl
          .registerPrayerTimesNotificationsTask();
    } else {
      await prayerTimesNotificationsRepo.cancelRemainingPrayersToday();
      await NotificationsBackgroundTasksRepoImpl
          .cancelPrayerTimesNotificationsTask();
    }
    settingsPageState.value = SettingsPageState.idle;
    isPrayerEnabled.value = value;
  }

  Future<void> toggleAdhkar() async {
    settingsPageState.value = SettingsPageState.loading;
    final bool value = _cache.getboolFromCache(
            key: CacheConstants.isDailyAdhkarNotRegisteredInWorkManger) ??
        true;
    if (value) {
      await dailyAdhkarNotificationsRepo.rescheduleDailyAdhkar();
      await NotificationsBackgroundTasksRepoImpl
          .registerDailyAdhkarNotificationsTask();
    } else {
      await dailyAdhkarNotificationsRepo.cancelRemainingAdhkarToday();
      await NotificationsBackgroundTasksRepoImpl
          .cancelDailyAdhkarNotificationsTask();
    }
    settingsPageState.value = SettingsPageState.idle;
    isAdhkarEnabled.value = value;
  }
}
