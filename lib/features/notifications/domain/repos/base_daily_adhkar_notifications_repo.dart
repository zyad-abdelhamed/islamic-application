abstract class BaseDailyAdhkarNotificationsRepo {
  Future<void> scheduleDailyAdhkar({Duration? repeatEvery});
  Future<void> rescheduleDailyAdhkar(int newMinutes);
  Future<void> cancelRemainingAdhkarToday();
}
