class Apiconstants {
  static final String _latitude = '30.0444';
  static final String _longitude = '31.2357';

  static const String adhkarUrl =
      "https://raw.githubusercontent.com/nawafalqari/azkar-api/56df51279ab6eb86dc2f6202c7de26c8948331c1/azkar.json";

  static String getTimingsUrl =
      "https://api.aladhan.com/v1/timings?latitude=$_latitude&method=8&longitude=$_longitude";

  static String getnextPrayersUrl =
      "https://api.aladhan.com/v1/nextPrayer?latitude=$_latitude&method=8&longitude=$_longitude";
}
