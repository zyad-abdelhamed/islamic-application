import 'package:test_app/core/constants/tasks_constants.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/notifications/domain/repos/base_daily_adhkar_notifications_repo.dart';
import 'package:test_app/features/notifications/domain/repos/base_prayer_times_notifications_repo.dart';
import 'package:workmanager/workmanager.dart';

/// لازم تعرف الكول باك برا كلاس عشان Workmanager يقدر ينده عليه
void workManagerCallbackDispatcher() {
  final BasePrayerTimesNotificationsRepo prayerTimesNotificationsRepo =
      sl<BasePrayerTimesNotificationsRepo>();
  final BaseDailyAdhkarNotificationsRepo dailyAdhkarNotificationsRepo =
      sl<BaseDailyAdhkarNotificationsRepo>();

  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case TasksConstants.prayerTimestaskName:
        await prayerTimesNotificationsRepo.schedulePrayersNotifications();
        break;
      case TasksConstants.dailyAdhkarTaskName:
        await dailyAdhkarNotificationsRepo.scheduleDailyAdhkar();
        break;
    }
    return Future.value(true);
  });
}
