import 'package:flutter/material.dart';
import 'package:test_app/core/constants/cache_constants.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/cache_service.dart';
import 'package:test_app/features/app/presentation/controller/controllers/settings_page_controller.dart';
import 'package:test_app/features/notifications/domain/repos/base_daily_adhkar_notifications_repo.dart';
import 'package:test_app/features/notifications/domain/repos/base_prayer_times_notifications_repo.dart';
import 'package:test_app/features/notifications/domain/repos/notifications_background_tasks_base_repo.dart';

class NotificationsSettingsController {
  late final ValueNotifier<bool> isPrayerEnabled;
  late final ValueNotifier<bool> isAdhkarEnabled;
  late final ValueNotifier<SettingsPageState> settingsPageState;
  late final BaseCacheService _cache;
  late final BasePrayerTimesNotificationsRepo prayerTimesNotificationsRepo;
  late final BaseDailyAdhkarNotificationsRepo dailyAdhkarNotificationsRepo;
  late final NotificationsBackgroundTasksBaseRepo
      _notificationsBackgroundTasksRepo;

  NotificationsSettingsController(ValueNotifier<SettingsPageState> pageState) {
    // قراءة القيم من الكاش عند بدء الصفحة
    isPrayerEnabled = ValueNotifier<bool>(!(_cache.getboolFromCache(
            key: CacheConstants.isPrayerTimesNotRegisteredInWorkManger) ??
        true));
    isAdhkarEnabled = ValueNotifier<bool>(!(_cache.getboolFromCache(
            key: CacheConstants.isDailyAdhkarNotRegisteredInWorkManger) ??
        true));

    _cache = sl<BaseCacheService>();
    prayerTimesNotificationsRepo = sl<BasePrayerTimesNotificationsRepo>();
    dailyAdhkarNotificationsRepo = sl<BaseDailyAdhkarNotificationsRepo>();
    _notificationsBackgroundTasksRepo =
        sl<NotificationsBackgroundTasksBaseRepo>();

    settingsPageState = pageState;
  }

  void dispose() {
    isPrayerEnabled.dispose();
    isAdhkarEnabled.dispose();
  }

  Future<void> togglePrayer(bool value) async {
    settingsPageState.value = SettingsPageState.loading;
    isPrayerEnabled.value = value;
    if (value) {
      await _notificationsBackgroundTasksRepo
          .registerPrayerTimesNotificationsTask();
    } else {
      await prayerTimesNotificationsRepo.cancelRemainingPrayersToday();
      await _notificationsBackgroundTasksRepo
          .cancelPrayerTimesNotificationsTask();
    }
    settingsPageState.value = SettingsPageState.idle;
  }

  Future<void> toggleAdhkar(bool value) async {
    settingsPageState.value = SettingsPageState.loading;
    isAdhkarEnabled.value = value;
    if (value) {
      await _notificationsBackgroundTasksRepo
          .registerDailyAdhkarNotificationsTask();
    } else {
      await dailyAdhkarNotificationsRepo.cancelRemainingAdhkarToday();
      await _notificationsBackgroundTasksRepo
          .cancelDailyAdhkarNotificationsTask();
    }
    settingsPageState.value = SettingsPageState.idle;
  }
}
