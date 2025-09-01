import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:test_app/core/helper_function/get_random.dart';
import 'package:test_app/core/models/notification_request_prameters.dart';
import 'package:test_app/core/services/notifications_service.dart';
import 'package:test_app/features/notifications/data/data_sources/local_data_source/daily_adhkar_notifications_local_data_source.dart';
import 'package:test_app/features/notifications/domain/repos/base_daily_adhkar_notifications_repo.dart';

class DailyAdhkarNotificationsRepoImpl
    implements BaseDailyAdhkarNotificationsRepo {
  const DailyAdhkarNotificationsRepoImpl(
      this.localDataSource, this.notifications);

  final BaseDailyAdhkarNotificationsLocalDataSource localDataSource;
  final BaseNotificationsService notifications;

  @override
  Future<void> scheduleDailyAdhkar({Duration? repeatEvery}) async {
    // تحديد الفاصل الزمني (من الكاش أو من البراميتر)
    final int minutes = repeatEvery?.inMinutes ?? localDataSource.getMinutes();
    final Duration interval = Duration(minutes: minutes);

    // جلب قائمة الأذكار
    final List<String> adhkar = [
      "سبحان الله",
      "الحمد لله",
      "الله أكبر",
      "لا إله إلا الله",
      "لا حول ولا قوة إلا بالله",
      "اللهم صل وسلم على نبينا محمد",
      "لا إله إلا أنت سبحانك إني كنت من الظالمين",
      "لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير",
      "أستغفر الله العظيم الذي لا إله إلا هو الحي القيوم وأتوب إليه",
      "سبحان الله وبحمده سبحان الله العظيم",
    ];

    final DateTime now = DateTime.now();

    // حساب عدد إشعارات اليوم
    final int totalCount = ((24 * 60) ~/ minutes);

    // تفاصيل الإشعار
    final AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'adhkar_channel',
      'Adhkar',
      channelDescription: 'Random adhkar notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('adhkar'),
    );
    final iosDetails = DarwinNotificationDetails();
    final details =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    for (int i = 0; i < totalCount; i++) {
      final scheduledTime = now.add(interval * i);

      // تخطي أي وقت ماضي
      if (scheduledTime.isBefore(DateTime.now())) continue;

      final NotificationRequestPrameters request = NotificationRequestPrameters(
        id: 10000 + i + 1, // IDs كبيرة لتجنب التعارض مع الصلوات
        title: "",
        body: adhkar[getRandomNumber(adhkar.length)],
        notificationDetails: details,
        scheduledTime: scheduledTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );

      await notifications.zonedSchedule(request);
    }

    // تخزين الفاصل الجديد
    await localDataSource.setMinutes(minutes);
  }

  @override
  Future<void> rescheduleDailyAdhkar(int newMinutes) async {
    // جلب الفاصل القديم
    final oldMinutes = localDataSource.getMinutes();
    final oldTotalCount = ((24 * 60) ~/ oldMinutes);

    // إلغاء إشعارات اليوم القديمة للأذكار فقط (IDs تبدأ من 10001)
    for (int i = 0; i < oldTotalCount; i++) {
      await notifications.cancel(10000 + i + 1);
    }

    // تخزين الفاصل الجديد
    await localDataSource.setMinutes(newMinutes);

    // جدولة إشعارات جديدة
    await scheduleDailyAdhkar(repeatEvery: Duration(minutes: newMinutes));
  }

  @override

  /// يلغي إشعارات الأذكار المتبقية لليوم فقط
  Future<void> cancelRemainingAdhkarToday() async {
    final now = DateTime.now();

    final int minutes = localDataSource.getMinutes();

    // عدد الإشعارات اليومية = 24 ساعة ÷ الفاصل
    final int totalCount = (24 * 60) ~/ minutes;

    for (int i = 0; i < totalCount; i++) {
      final scheduledTime = DateTime(now.year, now.month, now.day, 0, 0)
          .add(Duration(minutes: i * minutes));

      if (scheduledTime.isAfter(now)) {
        await notifications.cancel(10000 + i + 1);
      }
    }
  }
}
