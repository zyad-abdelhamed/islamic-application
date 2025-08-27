import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:test_app/core/constants/cache_constants.dart';
import 'package:test_app/core/helper_function/get_random.dart';
import 'package:test_app/core/models/notification_request_prameters.dart';
import 'package:test_app/core/services/cache_service%20copy.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/notifications_service.dart';
import '../constants/app_strings.dart';

/// جدولة إشعارات يوم كامل من الأذكار بشكل آمن
Future<void> scheduleDailyAdhkar({Duration? repeatEvery}) async {
  final BaseCacheService cache = sl<BaseCacheService>();
  final BaseNotificationsService notifications = sl<BaseNotificationsService>();

  // تحديد الفاصل الزمني (من الكاش أو من البراميتر)
  final minutes = repeatEvery?.inMinutes ??
      cache.getIntFromCache(key: CacheConstants.repeatIntervalKey) ??
      60;
  final interval = Duration(minutes: minutes);

  // حساب عدد الإشعارات ليوم كامل (24 ساعة)
  final totalCount = ((24 * 60) ~/ minutes);

  // جلب قائمة الأذكار
  final List adhkar = AppStrings.translate("adhkarList");

  // تفاصيل الإشعار
  final androidDetails = AndroidNotificationDetails(
    'adhkar_channel',
    'Adhkar',
    channelDescription: 'Random adhkar notifications',
    importance: Importance.max,
    priority: Priority.high,
  );
  final iosDetails = DarwinNotificationDetails();
  final details = NotificationDetails(android: androidDetails, iOS: iosDetails);

  final now = DateTime.now();

  for (int i = 0; i < totalCount; i++) {
    final scheduledTime = now.add(interval * i);

    // تخطي أي وقت ماضي
    if (scheduledTime.isBefore(DateTime.now())) continue;

    final request = NotificationRequestPrameters(
      id: i + 1,
      title: "ذِكر اليوم",
      body: adhkar[getRandomNumber(adhkar.length)],
      notificationDetails: details,
      scheduledTime: scheduledTime,
    );

    await notifications.zonedSchedule(request);
  }

  // تخزين تاريخ اليوم
  final todayKey = "${now.year}-${now.month}-${now.day}";
  await cache.insertStringToCache(
      key: CacheConstants.lastScheduledDayKey, value: todayKey);
}

/// إعادة جدولة الإشعارات بعد تغيير الفاصل الزمني
Future<void> rescheduleDailyAdhkar(int minutes) async {
  final BaseCacheService cache = sl<BaseCacheService>();
  final BaseNotificationsService notifications = sl<BaseNotificationsService>();

  // تخزين القيمة الجديدة
  await cache.insertIntToCache(
      key: CacheConstants.repeatIntervalKey, value: minutes);

  // إلغاء أي إشعارات قديمة
  await notifications.cancelAll();

  // تجهيز إشعارات جديدة بالمدة الجديدة
  await scheduleDailyAdhkar(repeatEvery: Duration(minutes: minutes));

  // تخزين تاريخ اليوم
  final DateTime today = DateTime.now();
  final String todayKey = "${today.year}-${today.month}-${today.day}";
  await cache.insertStringToCache(
      key: CacheConstants.lastScheduledDayKey, value: todayKey);
}
