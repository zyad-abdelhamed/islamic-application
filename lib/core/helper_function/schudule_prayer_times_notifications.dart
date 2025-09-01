// import 'package:dartz/dartz.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:test_app/core/errors/failures.dart';
// import 'package:test_app/core/models/notification_request_prameters.dart';
// import 'package:test_app/core/services/dependency_injection.dart';
// import 'package:test_app/core/services/notifications_service.dart';
// import 'package:test_app/core/theme/app_colors.dart';
// import 'package:test_app/features/app/domain/entities/prayer_sound_settings_entity.dart';
// import 'package:test_app/features/app/domain/entities/timings.dart';
// import 'package:test_app/features/app/domain/repositories/base_prayer_repo.dart';

// /// إشعارات الصلوات
// Future<void> schedulePrayersNotifications() async {
//   final BasePrayerRepo repo = sl<BasePrayerRepo>();
//   final BaseNotificationsService notifications = sl<BaseNotificationsService>();

//   // جلب إعدادات الصوت من الريبو
//   final settingsResult = await repo.getPrayersSoundSettings();

//   final PrayerSoundSettingsEntity settings = settingsResult.fold(
//     (_) => const PrayerSoundSettingsEntity(
//       fajr: true,
//       dhuhr: true,
//       asr: true,
//       maghrib: true,
//       isha: true,
//     ),
//     (settings) => settings,
//   );

//   final result = await repo.getPrayerTimes();

//   return await result.fold(
//     (_) {},
//     (Timings timings) async {
//       if (settings.fajr) {
//         await _schedulePrayer(
//           id: 1,
//           title: "آذان الفجر",
//           body: "حان الآن موعد آذان الفجر",
//           time: timings.fajr,
//           notifications: notifications,
//         );
//       }
//       if (settings.dhuhr) {
//         await _schedulePrayer(
//           id: 2,
//           title: "آذان الظهر",
//           body: "حان الآن موعد آذان الظهر",
//           time: timings.dhuhr,
//           notifications: notifications,
//         );
//       }
//       if (settings.asr) {
//         await _schedulePrayer(
//           id: 3,
//           title: "آذان العصر",
//           body: "حان الآن موعد آذان العصر",
//           time: timings.asr,
//           notifications: notifications,
//         );
//       }
//       if (settings.maghrib) {
//         await _schedulePrayer(
//           id: 4,
//           title: "آذان المغرب",
//           body: "حان الآن موعد آذان المغرب",
//           time: timings.maghrib,
//           notifications: notifications,
//         );
//       }
//       if (settings.isha) {
//         await _schedulePrayer(
//           id: 5,
//           title: "آذان العشاء",
//           body: "حان الآن موعد آذان العشاء",
//           time: timings.isha,
//           notifications: notifications,
//         );
//       }
//     },
//   );
// }

// /// تفاصيل إشعار Full-Screen مع زر إلغاء لكل صلاة
// NotificationDetails _notificationDetails(int id) {
//   return NotificationDetails(
//     android: AndroidNotificationDetails(
//       'prayer_channel',
//       'Prayer Notifications',
//       channelDescription: 'إشعارات الأذان',
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//       sound: RawResourceAndroidNotificationSound('aladhan'),
//       fullScreenIntent: true,
//       color: AppColors.lightModePrimaryColor,
//       colorized: true, // مهم للون
//       enableLights: true,
//       actions: <AndroidNotificationAction>[
//         AndroidNotificationAction(
//           'cancel_action_$id', // معرف الإلغاء حسب الصلاة
//           'إلغاء',
//           cancelNotification: true,
//         ),
//       ],
//     ),
//     iOS: DarwinNotificationDetails(
//       presentSound: true,
//       presentAlert: true,
//       presentBadge: true,
//       sound: 'adhan.mp3',
//     ),
//   );
// }

// Future<void> _schedulePrayer({
//   required int id,
//   required String title,
//   required String body,
//   required String time,
//   required BaseNotificationsService notifications,
// }) async {
//   final scheduledTime = _parseTime(time);

//   // تجاهل أي وقت فات
//   if (scheduledTime.isBefore(DateTime.now())) {
//     return;
//   }

//   await notifications.zonedSchedule(
//     NotificationRequestPrameters(
//       id: id,
//       title: title,
//       body: body,
//       scheduledTime: scheduledTime,
//       notificationDetails: _notificationDetails(id),
//       androidScheduleMode: AndroidScheduleMode.exact,
//     ),
//   );
// }

// /// تحويل "hh:mm" إلى DateTime اليوم
// DateTime _parseTime(String time) {
//   final now = DateTime.now();
//   final parts = time.split(":");
//   final hour = int.parse(parts[0]);
//   final minute = int.parse(parts[1]);
//   return DateTime(now.year, now.month, now.day, hour, minute);
// }

// /// إلغاء إشعار محدد
// Future<void> cancelPrayerNotification(int id) async {
//   final BaseNotificationsService notifications = sl<BaseNotificationsService>();
//   await notifications.cancel(id);
// }

// /// إعادة جدولة الصلوات المتبقية لليوم
// Future<void> rescheduleRemainingPrayers(
//     PrayerSoundSettingsEntity settings) async {
//   final BasePrayerRepo repo = sl<BasePrayerRepo>();
//   final BaseNotificationsService notifications = sl<BaseNotificationsService>();

//   // جلب أوقات الصلاة
//   final Either<Failure, Timings> result = await repo.getPrayerTimes();

//   await result.fold(
//     (_) {},
//     (Timings timings) async {
//       final now = DateTime.now();

//       // قائمة الصلوات
//       final List<Map<String, dynamic>> prayers = [
//         {
//           'id': 1,
//           'time': timings.fajr,
//           'enabled': settings.fajr,
//           'title': 'آذان الفجر',
//           'body': 'حان الآن موعد آذان الفجر'
//         },
//         {
//           'id': 2,
//           'time': timings.dhuhr,
//           'enabled': settings.dhuhr,
//           'title': 'آذان الظهر',
//           'body': 'حان الآن موعد آذان الظهر'
//         },
//         {
//           'id': 3,
//           'time': timings.asr,
//           'enabled': settings.asr,
//           'title': 'آذان العصر',
//           'body': 'حان الآن موعد آذان العصر'
//         },
//         {
//           'id': 4,
//           'time': timings.maghrib,
//           'enabled': settings.maghrib,
//           'title': 'آذان المغرب',
//           'body': 'حان الآن موعد آذان المغرب'
//         },
//         {
//           'id': 5,
//           'time': timings.isha,
//           'enabled': settings.isha,
//           'title': 'آذان العشاء',
//           'body': 'حان الآن موعد آذان العشاء'
//         },
//       ];

//       for (var prayer in prayers) {
//         final String timeStr = prayer['time']?.toString() ?? "00:00";
//         final List<String> prayerTimeParts = timeStr.split(":");

//         final prayerDateTime = DateTime(
//           now.year,
//           now.month,
//           now.day,
//           int.parse(prayerTimeParts[0]),
//           int.parse(prayerTimeParts[1]),
//         );

//         // فقط إذا الوقت لم يحن بعد
//         if (prayerDateTime.isAfter(now)) {
//           // إلغاء أي إشعار موجود مسبقًا
//           await notifications.cancel(prayer['id'] as int);

//           // إعادة الجدولة إذا مفعل
//           if (prayer['enabled'] as bool) {
//             await _schedulePrayer(
//               id: prayer['id'] as int,
//               title: prayer['title'] as String,
//               body: prayer['body'] as String,
//               time: prayer['time'] as String,
//               notifications: notifications,
//             );
//           }
//         }
//       }
//     },
//   );
// }
