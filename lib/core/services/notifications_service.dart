import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:test_app/core/models/notification_request_prameters.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz1;

abstract class BaseNotificationsService {
  Future<void> init() async {
    // initialize timezone data
    tz1.initializeTimeZones();
  }

  Future<void> periodicallyShowWithDuration(
      NotificationRequestPrameters request);

  /// جدولة إشعار بوقت محدد باستخدام timezone
  Future<void> zonedSchedule(NotificationRequestPrameters request);

  /// إلغاء إشعار معين
  Future<void> cancel(int id);

  /// إلغاء كل الإشعارات
  Future<void> cancelAll();
}

class NotificationsServiceByFlutterLocalNotifications
    extends BaseNotificationsService {
  final FlutterLocalNotificationsPlugin instance =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> init() async {
    super.init();
    final settings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/launcher_icon"),
      iOS: DarwinInitializationSettings(),
    );
    await instance.initialize(settings);
  }

  @override
  Future<void> periodicallyShowWithDuration(
      NotificationRequestPrameters request) async {
    if (request.repeatDuration == null) {
      throw ArgumentError("repeatDuration must not be null "
          "when using periodicallyShowWithDuration");
    }

    // استدعاء الدالة من المكتبة لعرض إشعار متكرر كل مدة معينة
    await instance.periodicallyShowWithDuration(
      // رقم مميز لكل إشعار عشان لو حبيت تحدثه أو تلغيه
      request.id,

      // العنوان اللي هيظهر في الإشعار
      request.title,

      // النص الأساسي للإشعار
      request.body,

      // المدة الزمنية بين كل إشعار والتاني (لازم تكون دقيقة أو أكتر)
      request.repeatDuration!,

      // تفاصيل الإشعار (إعدادات Android و iOS زي القناة والأيقونة والأولوية)
      request.notificationDetails,

      // وضع الجدولة في أندرويد:
      // - inexact (افتراضي): النظام ممكن يزحزح الوقت شوية لتوفير البطارية
      // - exact: يحاول يرن في الوقت بالضبط
      // - exactAllowWhileIdle: يرن بالضبط حتى لو الجهاز في وضع توفير الطاقة
      androidScheduleMode: // هذا الإعداد خاص بأندرويد فقط، iOS لا يستخدم androidScheduleMode والنظام هناك يتولى إدارة التنبيهات بشكل تلقائي
          request.androidScheduleMode ?? AndroidScheduleMode.inexact,
    );
  }

  @override
  Future<void> zonedSchedule(NotificationRequestPrameters request) async {
    // لازم يكون عندنا وقت محدد علشان نقدر نعمل جدولة
    if (request.scheduledTime == null) {
      throw ArgumentError("scheduledTime must not be null "
          "when using zonedSchedule");
    }

    // تحويل وقت الجدولة العادي (DateTime) إلى وقت مرتبط بالـ timezone المحلي
    final tz.TZDateTime scheduledDate =
        tz.TZDateTime.from(request.scheduledTime!, tz.local);

    // استدعاء دالة المكتبة لجدولة الإشعار
    await instance.zonedSchedule(
      // رقم مميز للإشعار
      request.id,

      // العنوان اللي هيظهر في الإشعار
      request.title,

      // النص الأساسي للإشعار
      request.body,

      // الوقت اللي هيظهر فيه الإشعار (بالـ timezone المحلي)
      scheduledDate,

      // وضع الجدولة في أندرويد:
      // - inexact (افتراضي): النظام ممكن يزحزح الوقت شوية لتوفير البطارية
      // - exact: يحاول يرن في الوقت بالضبط
      // - exactAllowWhileIdle: يرن بالضبط حتى لو الجهاز في وضع توفير الطاقة
      androidScheduleMode: // هذا الإعداد خاص بأندرويد فقط، iOS لا يستخدم androidScheduleMode والنظام هناك يتولى إدارة التنبيهات بشكل تلقائي
          request.androidScheduleMode ?? AndroidScheduleMode.inexact,

      // تفاصيل الإشعار (Android + iOS)
      request.notificationDetails,

      // هنا ممكن نحدد نوع التكرار:
      // - DateTimeComponents.time = يتكرر يومياً في نفس الساعة والدقيقة
      // - DateTimeComponents.dayOfWeekAndTime = يتكرر أسبوعياً في نفس اليوم والوقت
      // - null = مرة واحدة فقط
      matchDateTimeComponents: null,
    );
  }

  @override
  Future<void> cancel(int id) async {
    await instance.cancel(id);
  }

  @override
  Future<void> cancelAll() async {
    await instance.cancelAll();
  }
}
