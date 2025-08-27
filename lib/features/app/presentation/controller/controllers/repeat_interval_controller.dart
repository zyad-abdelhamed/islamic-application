import 'package:flutter/material.dart';
import 'package:test_app/core/constants/cache_constants.dart';
import 'package:test_app/core/helper_function/schedule_daily_adhkar_notification.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/cache_service%20copy.dart';

class RepeatIntervalProvider extends ChangeNotifier {
  final BaseCacheService _cache = sl<BaseCacheService>();

  int _currentMinutes = 60; // القيمة الحالية
  int _savedMinutes = 60; // القيمة المخزنة في الكاش

  RepeatIntervalProvider() {
    _loadFromCache();
  }

  // getter للقيمة الحالية
  int get currentMinutes => _currentMinutes;

  // تحقق لو القيمة تغيرت عن المخزنة
  bool get isChanged => _currentMinutes != _savedMinutes;

  // تحويل دقائق لساعات + دقائق
  String get formattedTime {
    final h = _currentMinutes ~/ 60;
    final m = _currentMinutes % 60;
    if (h > 0 && m > 0) return "$h ساعة و $m دقيقة";
    if (h > 0) return "$h ساعة";
    return "$m دقيقة";
  }

  // لون الـ Slider على حسب القيمة
  Color get sliderColor {
    final double percent = (_currentMinutes - 10) / (180 - 10);
    return Color.lerp(Colors.lightBlueAccent, Colors.blue.shade800, percent)!;
  }

  // تحميل القيمة من الكاش
  void _loadFromCache() {
    final int saved =
        _cache.getIntFromCache(key: CacheConstants.repeatIntervalKey) ?? 60;
    _savedMinutes = saved;
    _currentMinutes = saved;
    notifyListeners();
  }

  // تحديث القيمة من الـ Slider
  void updateMinutes(int minutes) {
    _currentMinutes = minutes;
    notifyListeners();
  }

  // حفظ القيمة وإعادة جدولة إشعارات اليوم
  Future<void> saveInterval() async {
    await rescheduleDailyAdhkar(_currentMinutes);
    _savedMinutes = _currentMinutes;
    notifyListeners();
  }
}
