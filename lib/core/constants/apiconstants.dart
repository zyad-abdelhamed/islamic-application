class Apiconstants {
  static const String adhkarUrl =
      "https://raw.githubusercontent.com/nawafalqari/azkar-api/56df51279ab6eb86dc2f6202c7de26c8948331c1/azkar.json";

  static String getTimingsUrl(String latitude, String longitude) =>
      "https://api.aladhan.com/v1/timings?latitude=$latitude&method=8&longitude=$longitude";
}
