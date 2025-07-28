import 'package:equatable/equatable.dart';

class Timings extends Equatable {
  final String date, fajr, sunrise, dhuhr, asr, maghrib, isha;
  const Timings(
      {required this.date,
      required this.fajr,
      required this.sunrise,
      required this.dhuhr,
      required this.asr,
      required this.maghrib,
      required this.isha});

  @override
  List<Object?> get props => [date, fajr, sunrise, dhuhr, asr, maghrib, isha];
}
