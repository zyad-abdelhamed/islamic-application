import 'package:flutter/services.dart';

class StatusBarUtils {
  /// إخفاء الـ Status Bar
  static Future<void> hide() async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
  }

  /// إظهار الـ Status Bar (الوضع الطبيعي)
  static Future<void> show() async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );
  }
}
