import 'package:equatable/equatable.dart';

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
