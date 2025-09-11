import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationRequestPrameters {
  final int id;
  final String title;
  final String body;
  final String? payload;

  /// للجدولة بوقت محدد
  final DateTime? scheduledTime;

  /// للجدولة مع timezone
  final tz.TZDateTime? scheduledTZTime;

  /// للتكرار بالـ Duration
  final Duration? repeatDuration;

  /// للتكرار الثابت (كل ساعة/يومي/أسبوعي...)
  final RepeatInterval? repeatInterval;

  /// تفاصيل الإشعار
  final NotificationDetails notificationDetails;

  /// وضع الجدولة في Android
  final AndroidScheduleMode? androidScheduleMode;

  /// يرن مرة واحدة ولا متكرر؟
  final bool repeat;

  final DateTimeComponents? dateTimeComponents;

  const NotificationRequestPrameters({
    required this.id,
    required this.title,
    required this.body,
    this.payload,
    required this.notificationDetails,
    this.scheduledTime,
    this.scheduledTZTime,
    this.repeatDuration,
    this.repeatInterval,
    this.androidScheduleMode,
    this.repeat = false,
    this.dateTimeComponents,
  });
}
