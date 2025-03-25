import 'package:test_app/app/domain/entities/timings.dart';

class TimingsModel extends Timings {
  const TimingsModel(
      {required super.fajr,
      required super.sunrise,
      required super.dhuhr,
      required super.asr,
      required super.maghrib,
      required super.isha});

  factory TimingsModel.fromJson(Map<String, dynamic> json) => TimingsModel(
      fajr: json['Fajr'],
      sunrise: json['Sunrise'],
      dhuhr: json['Dhuhr'],
      asr: json['Asr'],
      maghrib: json['Maghrib'],
      isha: json['Isha']);
}
