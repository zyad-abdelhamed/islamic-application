// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:test_app/core/constants/cache_constants.dart';
// import 'package:test_app/core/helper_function/get_random.dart';
// import 'package:test_app/core/models/notification_request_prameters.dart';
// import 'package:test_app/core/services/cache_service.dart';
// import 'package:test_app/core/services/dependency_injection.dart';
// import 'package:test_app/core/services/notifications_service.dart';

// /// جدولة إشعارات يوم كامل من الأذكار بشكل آمن
// Future<void> scheduleDailyAdhkar({Duration? repeatEvery}) async {
//   final BaseCacheService cache = sl<BaseCacheService>();
//   final BaseNotificationsService notifications = sl<BaseNotificationsService>();

//   // تحديد الفاصل الزمني (من الكاش أو من البراميتر)
//   final int minutes = repeatEvery?.inMinutes ??
//       cache.getIntFromCache(key: CacheConstants.repeatIntervalKey) ??
//       60;
//   final Duration interval = Duration(minutes: minutes);

//   // جلب قائمة الأذكار
//   final List<String> adhkar = [
//     "سبحان الله",
//     "الحمد لله",
//     "الله أكبر",
//     "لا إله إلا الله",
//     "لا حول ولا قوة إلا بالله",
//     "اللهم صل وسلم على نبينا محمد",
//     "لا إله إلا أنت سبحانك إني كنت من الظالمين",
//     "لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير",
//     "أستغفر الله العظيم الذي لا إله إلا هو الحي القيوم وأتوب إليه",
//     "سبحان الله وبحمده سبحان الله العظيم",
//   ];

//   final DateTime now = DateTime.now();

//   // حساب عدد إشعارات اليوم
//   final int totalCount = ((24 * 60) ~/ minutes);

//   // تفاصيل الإشعار
//   final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//     'adhkar_channel',
//     'Adhkar',
//     channelDescription: 'Random adhkar notifications',
//     importance: Importance.max,
//     priority: Priority.high,
//     playSound: true,
//     sound: RawResourceAndroidNotificationSound('adhkar'),
//   );
//   final iosDetails = DarwinNotificationDetails();
//   final details = NotificationDetails(android: androidDetails, iOS: iosDetails);

//   for (int i = 0; i < totalCount; i++) {
//     final scheduledTime = now.add(interval * i);

//     // تخطي أي وقت ماضي
//     if (scheduledTime.isBefore(DateTime.now())) continue;

//     final NotificationRequestPrameters request = NotificationRequestPrameters(
//       id: 10000 + i + 1, // IDs كبيرة لتجنب التعارض مع الصلوات
//       title: "",
//       body: adhkar[getRandomNumber(adhkar.length)],
//       notificationDetails: details,
//       scheduledTime: scheduledTime,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//     );

//     await notifications.zonedSchedule(request);
//   }

//   // تخزين تاريخ اليوم
//   final String todayKey = "${now.year}-${now.month}-${now.day}";
//   await cache.insertStringToCache(
//       key: CacheConstants.lastScheduledDayKey, value: todayKey);

//   // تخزين الفاصل الجديد
//   await cache.insertIntToCache(
//       key: CacheConstants.repeatIntervalKey, value: minutes);
// }

// /// إعادة جدولة إشعارات اليوم فقط مع الفاصل الجديد
// Future<void> rescheduleDailyAdhkar(int newMinutes) async {
//   final BaseCacheService cache = sl<BaseCacheService>();
//   final BaseNotificationsService notifications = sl<BaseNotificationsService>();

//   // جلب الفاصل القديم
//   final oldMinutes =
//       cache.getIntFromCache(key: CacheConstants.repeatIntervalKey) ?? 60;
//   final oldTotalCount = ((24 * 60) ~/ oldMinutes);

//   // إلغاء إشعارات اليوم القديمة للأذكار فقط (IDs تبدأ من 10001)
//   for (int i = 0; i < oldTotalCount; i++) {
//     await notifications.cancel(10000 + i + 1);
//   }

//   // تخزين الفاصل الجديد
//   await cache.insertIntToCache(
//       key: CacheConstants.repeatIntervalKey, value: newMinutes);

//   // جدولة إشعارات جديدة
//   await scheduleDailyAdhkar(repeatEvery: Duration(minutes: newMinutes));
// }
