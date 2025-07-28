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
  });

  factory TimingsModel.fromJson(Map<String, dynamic> json) {
    final hijriJson = json['date']['hijri'];

    return TimingsModel(
      fajr: json['timings']['Fajr'],
      sunrise: json['timings']['Sunrise'],
      dhuhr: json['timings']['Dhuhr'],
      asr: json['timings']['Asr'],
      maghrib: json['timings']['Maghrib'],
      isha: json['timings']['Isha'],
      hijriDay: hijriJson['day'],
      hijriMonthNameArabic: hijriJson['month']['ar'],
      hijriYear: hijriJson['year'],
    );
  }
}
