part of 'prayer_times_cubit.dart';

class PrayerTimesState extends Equatable {
  final Timings? prayerTimes;
  final String errorMessageofPrayerTimes;
  final RequestStateEnum requestStateofPrayerTimes;
  const PrayerTimesState(
      {this.prayerTimes ,
      this.errorMessageofPrayerTimes = '',
      this.requestStateofPrayerTimes = RequestStateEnum.loading});

  @override
  List<Object?> get props =>
      [prayerTimes, errorMessageofPrayerTimes, requestStateofPrayerTimes];
}
