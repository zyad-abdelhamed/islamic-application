import 'package:dartz/dartz.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/models/notification_request_prameters.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/notifications_service.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/data/datasources/prayers_local_data_source.dart';
import 'package:test_app/features/app/domain/entities/prayer_sound_settings_entity.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/domain/repositories/base_prayer_repo.dart';
import 'package:test_app/features/notifications/domain/repos/base_prayer_times_notifications_repo.dart';

class PrayerTimesNotificationsRepoImpl
    implements BasePrayerTimesNotificationsRepo {
  const PrayerTimesNotificationsRepoImpl(
      this.repo, this.notifications, this.prayersLocalDataSource);

  final BasePrayerRepo repo;
  final BaseNotificationsService notifications;
  final PrayersLocalDataSource prayersLocalDataSource;

  @override
  Future<void> schedulePrayersNotifications() async {
    final PrayerSoundSettingsEntity soundSettings = await _getSoundSettings();
    final Either<Failure, Timings> result = await repo.getPrayerTimes();

    return await result.fold(
      (_) {},
      (Timings timings) async {
        await _schedulePrayer(
          id: 1,
          isPrayerNotificationEnabled: soundSettings.fajr,
          title: "آذان الفجر",
          body: "حان الآن موعد آذان الفجر",
          time: timings.fajr,
          notifications: notifications,
        );

        await _schedulePrayer(
          id: 2,
          isPrayerNotificationEnabled: soundSettings.dhuhr,
          title: "آذان الظهر",
          body: "حان الآن موعد آذان الظهر",
          time: timings.dhuhr,
          notifications: notifications,
        );

        await _schedulePrayer(
          id: 3,
          isPrayerNotificationEnabled: soundSettings.asr,
          title: "آذان العصر",
          body: "حان الآن موعد آذان العصر",
          time: timings.asr,
          notifications: notifications,
        );

        await _schedulePrayer(
          id: 4,
          isPrayerNotificationEnabled: soundSettings.maghrib,
          title: "آذان المغرب",
          body: "حان الآن موعد آذان المغرب",
          time: timings.maghrib,
          notifications: notifications,
        );

        await _schedulePrayer(
          id: 5,
          isPrayerNotificationEnabled: soundSettings.isha,
          title: "آذان العشاء",
          body: "حان الآن موعد آذان العشاء",
          time: timings.isha,
          notifications: notifications,
        );
      },
    );
  }

  @override

  /// إلغاء إشعار محدد
  Future<void> cancelPrayerNotification(int id) async {
    final BaseNotificationsService notifications =
        sl<BaseNotificationsService>();
    await notifications.cancel(id);
  }

  @override
  Future<void> rescheduleRemainingPrayers(
      PrayerSoundSettingsEntity soundSettings) async {
    // جلب أوقات الصلاة
    final Either<Failure, Timings> result = await repo.getPrayerTimes();

    await result.fold(
      (_) {},
      (Timings timings) async {
        final now = DateTime.now();

        // قائمة الصلوات
        final List<Map<String, dynamic>> prayers = [
          {
            'id': 1,
            'time': timings.fajr,
            'enabled': soundSettings.fajr,
            'title': 'آذان الفجر',
            'body': 'حان الآن موعد آذان الفجر'
          },
          {
            'id': 2,
            'time': timings.dhuhr,
            'enabled': soundSettings.dhuhr,
            'title': 'آذان الظهر',
            'body': 'حان الآن موعد آذان الظهر'
          },
          {
            'id': 3,
            'time': timings.asr,
            'enabled': soundSettings.asr,
            'title': 'آذان العصر',
            'body': 'حان الآن موعد آذان العصر'
          },
          {
            'id': 4,
            'time': timings.maghrib,
            'enabled': soundSettings.maghrib,
            'title': 'آذان المغرب',
            'body': 'حان الآن موعد آذان المغرب'
          },
          {
            'id': 5,
            'time': timings.isha,
            'enabled': soundSettings.isha,
            'title': 'آذان العشاء',
            'body': 'حان الآن موعد آذان العشاء'
          },
        ];

        for (var prayer in prayers) {
          final String timeStr = prayer['time']?.toString() ?? "00:00";
          final List<String> prayerTimeParts = timeStr.split(":");

          final prayerDateTime = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(prayerTimeParts[0]),
            int.parse(prayerTimeParts[1]),
          );

          // فقط إذا الوقت لم يحن بعد
          if (prayerDateTime.isAfter(now)) {
            // إلغاء أي إشعار موجود مسبقًا
            await notifications.cancel(prayer['id'] as int);

            await _schedulePrayer(
              id: prayer['id'] as int,
              isPrayerNotificationEnabled: prayer['enabled'] as bool,
              title: prayer['title'] as String,
              body: prayer['body'] as String,
              time: prayer['time'] as String,
              notifications: notifications,
            );
          }
        }
      },
    );
  }

  @override
  Future<void> cancelRemainingPrayersToday() async {
    final DateTime now = DateTime.now();
    final Timings? timingsEntity =
        await prayersLocalDataSource.getLocalPrayersTimes();
    final List<String> prayerTimes = [
      timingsEntity!.fajr,
      timingsEntity.dhuhr,
      timingsEntity.asr,
      timingsEntity.maghrib,
      timingsEntity.isha
    ];

    for (int i = 1; i > 5; i++) {
      final DateTime time = _parseTime(prayerTimes[i - 1]);
      if (time.isAfter(now)) {
        await notifications.cancel(i);
      }
    }
  }

// helper functions
  Future<PrayerSoundSettingsEntity> _getSoundSettings() async {
    // جلب إعدادات الصوت من الريبو
    final Either<Failure, PrayerSoundSettingsEntity> settingsResult =
        await repo.getPrayersSoundSettings();

    final PrayerSoundSettingsEntity settings = settingsResult.fold(
      (_) => const PrayerSoundSettingsEntity(
        fajr: true,
        dhuhr: true,
        asr: true,
        maghrib: true,
        isha: true,
      ),
      (settings) => settings,
    );

    return settings;
  }

  /// تفاصيل إشعار Full-Screen مع زر إلغاء لكل صلاة
  NotificationDetails _notificationDetails(int id) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'prayer_channel',
        'Prayer Notifications',
        channelDescription: 'إشعارات الأذان',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('aladhan'),
        fullScreenIntent: true,
        color: AppColors.lightModePrimaryColor,
        colorized: true, // مهم للون
        enableLights: true,
        actions: <AndroidNotificationAction>[
          AndroidNotificationAction(
            'cancel_action_$id', // معرف الإلغاء حسب الصلاة
            'إلغاء',
            cancelNotification: true,
          ),
        ],
      ),
      iOS: DarwinNotificationDetails(
        presentSound: true,
        presentAlert: true,
        presentBadge: true,
        sound: 'adhan.mp3',
      ),
    );
  }

  Future<void> _schedulePrayer({
    required int id,
    required bool isPrayerNotificationEnabled,
    required String title,
    required String body,
    required String time,
    required BaseNotificationsService notifications,
  }) async {
    if (isPrayerNotificationEnabled) {
      final scheduledTime = _parseTime(time);

      // تجاهل أي وقت فات
      if (scheduledTime.isBefore(DateTime.now())) {
        return;
      }

      await notifications.zonedSchedule(
        NotificationRequestPrameters(
          id: id,
          title: title,
          body: body,
          scheduledTime: scheduledTime,
          notificationDetails: _notificationDetails(id),
          androidScheduleMode: AndroidScheduleMode.exact,
        ),
      );
    }
  }

  /// تحويل "hh:mm" إلى DateTime اليوم
  DateTime _parseTime(String time) {
    final now = DateTime.now();
    final parts = time.split(":");
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return DateTime(now.year, now.month, now.day, hour, minute);
  }
}
