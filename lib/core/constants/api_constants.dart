import 'package:geolocator/geolocator.dart';
import 'package:test_app/core/helper_function/get_random.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/position_service.dart';

class Apiconstants {
  static const String adhkarUrl =
      "https://raw.githubusercontent.com/nawafalqari/azkar-api/56df51279ab6eb86dc2f6202c7de26c8948331c1/azkar.json";

  static Future<String> get getTimingsUrl async {
    //final Position position = await sl<BasePositionService>().position;
    return "https://api.aladhan.com/v1/timings?latitude=3&method=8&longitude=3";
  }

  static String get ahadithUrl =>
      'https://hadis-api-id.vercel.app/hadith/abu-dawud?page=${getRandomNumber(4419)}&limit=1';
}
