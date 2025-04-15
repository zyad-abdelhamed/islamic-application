part of 'home_cubit.dart';

class PrayerTimesState extends Equatable {
  final Timings? prayerTimes;
  final String errorMessageofPrayerTimes;
  final RequestStateEnum requestStateofPrayerTimes;
  final PrayerTime? prayerTime;
  const PrayerTimesState(
      {this.prayerTimes ,this.prayerTime, 
      this.errorMessageofPrayerTimes = '',
      this.requestStateofPrayerTimes = RequestStateEnum.loading});

  @override
  List<Object?> get props =>
      [prayerTimes, errorMessageofPrayerTimes, requestStateofPrayerTimes, prayerTime];
}
