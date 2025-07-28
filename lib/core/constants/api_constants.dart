import 'package:geolocator/geolocator.dart';
import 'package:test_app/core/helper_function/get_random.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/features/app/data/models/get_prayer_times_of_month_prameters.dart';

class Apiconstants {
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

  static Future<String> getTimingsOfMonthUrl(
      GetPrayerTimesOfMonthPrameters getPrayerTimesOfMonthPrameters) async {
    try {
      final Position position = await sl<BaseLocationService>().position;

      // تأكد أن الإحداثيات ليست 0.0 (بعض الأجهزة تعيد 0.0 عند الفشل)
      if (position.latitude != 0.0 && position.longitude != 0.0) {
        return "https://api.aladhan.com/v1/calendar?latitude=${position.latitude}&method=8&longitude=${position.longitude}&month=${getPrayerTimesOfMonthPrameters.date.month}&year=${getPrayerTimesOfMonthPrameters.date.year}";
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
