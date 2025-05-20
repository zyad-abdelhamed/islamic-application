part of 'prayer_times_cubit.dart';

class PrayerTimesState extends Equatable {
  const PrayerTimesState(
      {this.prayerTimes,
      this.nextPrayer,
      this.errorMessageofPrayerTimes = '',
      this.requestStateofPrayerTimes = RequestStateEnum.loading});
  final Timings? prayerTimes;
  final String errorMessageofPrayerTimes;
  final RequestStateEnum requestStateofPrayerTimes;
  final NextPrayer? nextPrayer;

  PrayerTimesState copyWith(
      {Timings? prayerTimes,
      String? errorMessageofPrayerTimes,
      RequestStateEnum? requestStateofPrayerTimes,
      NextPrayer? nextPrayer}) {
    return PrayerTimesState(
      errorMessageofPrayerTimes:
          errorMessageofPrayerTimes ?? this.errorMessageofPrayerTimes,
      nextPrayer: nextPrayer ?? this.nextPrayer,
      prayerTimes: prayerTimes ?? this.prayerTimes,
      requestStateofPrayerTimes:
          requestStateofPrayerTimes ?? this.requestStateofPrayerTimes,
    );
  }

  @override
  List<Object?> get props => [
        prayerTimes,
        errorMessageofPrayerTimes,
        requestStateofPrayerTimes,
        nextPrayer,
      ];
}
