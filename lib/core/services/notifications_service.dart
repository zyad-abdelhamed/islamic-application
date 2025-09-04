import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:test_app/core/models/notification_request_prameters.dart';
import 'package:test_app/core/services/dependency_injection.dart';
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
    await super.init();
    final settings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/launcher_icon"),
      iOS: DarwinInitializationSettings(), // لاحقا يتم عمل الاعدادات الخاصه بها
    );
    await instance.initialize(
      settings,
      // onDidReceiveNotificationResponse: (details) async {
      //   if (details.actionId != null &&
      //       details.actionId!.startsWith('cancel_action_')) {
      //     final int prayerId =
      //         int.tryParse(details.actionId!.split('_').last) ?? 0;
      //     await prayerTimesNotificationsRepo.cancelPrayerNotification(prayerId);
      //   }
      // },
      // onDidReceiveBackgroundNotificationResponse:
      //     prayerNotificationBackgroundHandler,
      //   الـ details هنا جاي من النظام تلقائي.
// لو حاولت تستخدم closure أو lambda مباشرة، هتلاقي AssertionError لأن الخلفية ما بتعرفش على الـ closure.
// يعني: ما بتباصيش أي حاجة، النظام هو اللي بيمرر NotificationResponse للـ top-level function.
    );
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
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
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
      matchDateTimeComponents:
          null, // مهم نسيب دي كدا علشان الwork manger كل يوم يجدول اشعارات بالاوقات الجديده لان مثلاDateTimeComponents.time هيكرر الاشعار يوميا ف نفس الوقت
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

// ⚠️ مهم جدًا: أي كود في الـ background لازم يكون top-level، مش closures أو async lambdas داخل initialize.
// top-level function
@pragma('vm:entry-point')
Future<void> prayerNotificationBackgroundHandler(
    NotificationResponse details) async {
  if (details.actionId != null &&
      details.actionId!.startsWith('cancel_action_')) {
    final int prayerId = int.tryParse(details.actionId!.split('_').last) ?? 0;
    final BaseNotificationsService notifications =
        sl<BaseNotificationsService>();
    await notifications.cancel(prayerId);
  }
}
