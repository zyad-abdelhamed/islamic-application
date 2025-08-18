import 'package:test_app/core/services/arabic_converter_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';

class TimingsModel extends Timings {
  const TimingsModel({
    required super.fajr,
    required super.sunrise,
    required super.dhuhr,
    required super.asr,
    required super.maghrib,
    required super.isha,
    required super.hijriDay,
    required super.hijriMonthNameArabic,
    required super.hijriYear,
    required super.gregoriandate
  });

  factory TimingsModel.fromJson(Map<String, dynamic> json) {
    final hijriDateJson = json['date']['hijri'];
    final gregorianDateJson = json['date']['gregorian'];

    return TimingsModel(
      fajr: json['timings']['Fajr'],
      sunrise: json['timings']['Sunrise'],
      dhuhr: json['timings']['Dhuhr'],
      asr: json['timings']['Asr'],
      maghrib: json['timings']['Maghrib'],
      isha: json['timings']['Isha'],
      hijriDay: hijriDateJson['day'],
      hijriMonthNameArabic: hijriDateJson['month']['ar'],
      hijriYear: hijriDateJson['year'],
      gregoriandate: sl<BaseArabicConverterService>().convertToArabicDigits(gregorianDateJson['date'], pattern: '-')
    );
  }
}
