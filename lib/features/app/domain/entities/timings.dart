import 'package:equatable/equatable.dart';

class Timings extends Equatable {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  const Timings(
      {required this.fajr,
      required this.sunrise,
      required this.dhuhr,
      required this.asr,
      required this.maghrib,
      required this.isha});
  @override
  List<Object?> get props => [fajr, sunrise, dhuhr, asr, maghrib, isha];
}
