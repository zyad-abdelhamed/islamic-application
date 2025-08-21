import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class AdhanNotificationService {
  static Future<void> init() async {
     

    // إعداد المنطقة الزمنية
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
     

    // إعداد Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // إعداد iOS
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    // الدمج
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // تهيئة الإشعارات
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
     

    // طلب الإذن في Android
    final androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidImplementation != null) {
      bool? granted = await androidImplementation.requestNotificationsPermission();
       
    }

    // طلب الإذن في iOS
    final iosImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
    if (iosImplementation != null) {
      bool? granted = await iosImplementation.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
       
    }
  }

  static Future<void> scheduleAdhanNotification(DateTime scheduledTime) async {
     

    const androidDetails = AndroidNotificationDetails(
      'adhan_channel',
      'Adhan Notifications',
      sound: RawResourceAndroidNotificationSound('adhan'),
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const iosDetails = DarwinNotificationDetails(
      sound: 'adhan.mp3',
    );

    const platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'وقت الصلاة',
        'حان الآن موعد الأذان',
        tz.TZDateTime.from(scheduledTime, tz.local),
        platformDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
       
    } catch (e) {
       
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AdhanNotificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("اختبار الإشعارات")),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              DateTime testTime = DateTime.now().add(const Duration(seconds: 10));
               
              AdhanNotificationService.scheduleAdhanNotification(testTime);
            },
            child: const Text('تشغيل الإشعار بعد 10 ثواني'),
          ),
        ),
      ),
    );
  }
}
