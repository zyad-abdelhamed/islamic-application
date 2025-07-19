import 'package:geolocator/geolocator.dart';
import 'package:test_app/core/helper_function/get_random.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/position_service.dart';

class Apiconstants {
  static const String adhkarUrl =
      "https://raw.githubusercontent.com/nawafalqari/azkar-api/56df51279ab6eb86dc2f6202c7de26c8948331c1/azkar.json";

  static Future<String> get getTimingsUrl async {
    try {
      final Position position = await sl<BaseLocationService>().position;

      // تأكد أن الإحداثيات ليست 0.0 (بعض الأجهزة تعيد 0.0 عند الفشل)
      if (position.latitude != 0.0 && position.longitude != 0.0) {
        return "https://api.aladhan.com/v1/timings?latitude=${position.latitude}&method=8&longitude=${position.longitude}";
      }
    } catch (_) {
      // تجاهل الخطأ واستخدم القيم الافتراضية
    }

    // في حالة الفشل أو كانت الإحداثيات غير صالحة => استخدم إحداثيات القاهرة
    const cairoLatitude = 30.0444;
    const cairoLongitude = 31.2357;
    return "https://api.aladhan.com/v1/timings?latitude=$cairoLatitude&method=8&longitude=$cairoLongitude";
  }

  static String get ahadithUrl =>
      'https://hadis-api-id.vercel.app/hadith/abu-dawud?page=${getRandomNumber(4419)}&limit=1';
}
