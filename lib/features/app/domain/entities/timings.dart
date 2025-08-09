import 'package:equatable/equatable.dart';
import 'package:test_app/core/services/arabic_converter_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';

class Timings extends Equatable {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String hijriDay;
  final String hijriMonthNameArabic;
  final String hijriYear;
  final String gregoriandate;

  const Timings(
      {required this.fajr,
      required this.sunrise,
      required this.dhuhr,
      required this.asr,
      required this.maghrib,
      required this.isha,
      required this.hijriDay,
      required this.hijriMonthNameArabic,
      required this.hijriYear,
      required this.gregoriandate});

  /// تحويل الوقت إلى العربية باستخدام
  String get fajrArabic =>
      sl<BaseArabicConverterService>().convertTimeToArabic(fajr);
  String get sunriseArabic =>
      sl<BaseArabicConverterService>().convertTimeToArabic(sunrise);
  String get dhuhrArabic =>
      sl<BaseArabicConverterService>().convertTimeToArabic(dhuhr);
  String get asrArabic =>
      sl<BaseArabicConverterService>().convertTimeToArabic(asr);
  String get maghribArabic =>
      sl<BaseArabicConverterService>().convertTimeToArabic(maghrib);
  String get ishaArabic =>
      sl<BaseArabicConverterService>().convertTimeToArabic(isha);

  @override
  List<Object?> get props => [
        fajr,
        sunrise,
        dhuhr,
        asr,
        maghrib,
        isha,
        hijriDay,
        hijriMonthNameArabic,
        hijriYear,
        gregoriandate
      ];
  factory Timings.empty() {
    return const Timings(
        fajr: '00:00',
        dhuhr: '00:00',
        asr: '00:00',
        maghrib: '00:00',
        isha: '00:00',
        hijriDay: '',
        hijriMonthNameArabic: '',
        hijriYear: '',
        sunrise: '00:00',
        gregoriandate: '');
  }
}
