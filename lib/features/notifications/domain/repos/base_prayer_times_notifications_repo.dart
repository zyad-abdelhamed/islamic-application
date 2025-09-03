abstract class BasePrayerTimesNotificationsRepo {
  Future<void> schedulePrayersNotifications();
  Future<void> rescheduleRemainingPrayers();
  Future<void> cancelPrayerNotification(int id);
  Future<void> cancelRemainingPrayersToday();
}
