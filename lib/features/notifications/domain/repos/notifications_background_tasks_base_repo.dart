abstract class NotificationsBackgroundTasksBaseRepo {
  Future<void> registerDailyAdhkarNotificationsTask();
  Future<void> registerPrayerTimesNotificationsTask();
  Future<void> cancelDailyAdhkarNotificationsTask();
  Future<void> cancelPrayerTimesNotificationsTask();
}
