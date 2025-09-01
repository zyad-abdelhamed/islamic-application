// import 'package:test_app/core/constants/cache_constants.dart';
// import 'package:test_app/core/constants/tasks_constants.dart';
// import 'package:test_app/core/helper_function/schedule_daily_adhkar_notification.dart';
// import 'package:test_app/core/services/cache_service.dart';
// import 'package:test_app/core/services/dependency_injection.dart';
// import 'package:test_app/core/services/work_manger_service.dart';
// import 'package:test_app/features/notifications/domain/repos/base_prayer_times_notifications_repo.dart';

// Future<void> registerDailyAdhkarNotificationsTaskInWorkManger() async {
//   final BaseCacheService cache = sl<BaseCacheService>();

//   final bool isDailyAdhkarNotRegisteredInWorkManger = cache.getboolFromCache(
//           key: CacheConstants.isDailyAdhkarNotRegisteredInWorkManger) ??
//       true;

//   if (isDailyAdhkarNotRegisteredInWorkManger) {
//     await scheduleDailyAdhkar();
//     await sl<BaseWorkManagerService>().registerDailyTask(
//       TasksConstants.dailyAdhkarUniqueName,
//       TasksConstants.dailyAdhkarTaskName,
//     );

//     await cache.insertBoolToCache(
//         key: CacheConstants.isDailyAdhkarNotRegisteredInWorkManger,
//         value: false);
//   }
// }

// Future<void> registerPrayerTimesNotificationsTaskInWorkManger() async {
//   final BaseCacheService cache = sl<BaseCacheService>();

//   final bool isPrayerTimesNotRegisteredInWorkManger = cache.getboolFromCache(
//           key: CacheConstants.isPrayerTimesNotRegisteredInWorkManger) ??
//       true;

//   if (isPrayerTimesNotRegisteredInWorkManger) {
//     await schedulePrayersNotifications();
//     await sl<BaseWorkManagerService>().registerDailyTask(
//       TasksConstants.prayerTimesUniqueName,
//       TasksConstants.prayerTimestaskName,
//     );

//     await cache.insertBoolToCache(
//         key: CacheConstants.isPrayerTimesNotRegisteredInWorkManger,
//         value: false);
//   }
// }
