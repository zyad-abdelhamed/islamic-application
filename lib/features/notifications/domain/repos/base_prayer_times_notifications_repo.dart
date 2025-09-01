import 'package:test_app/features/app/domain/entities/prayer_sound_settings_entity.dart';

abstract class BasePrayerTimesNotificationsRepo {
  Future<void> schedulePrayersNotifications();
  Future<void> rescheduleRemainingPrayers(PrayerSoundSettingsEntity settings);
  Future<void> cancelPrayerNotification(int id);
  Future<void> cancelRemainingPrayersToday();
}
