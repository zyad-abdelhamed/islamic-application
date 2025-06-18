part of 'prayer_times_cubit.dart';

class PrayerTimesState extends Equatable {
  const PrayerTimesState(
      {this.prayerTimes = const ['','','','','',''],
      this.nextPrayer = const NextPrayer(name: '', time: ''),
      this.errorMessageofPrayerTimes = '',
      this.requestStateofPrayerTimes = RequestStateEnum.loading});
      
  final List<String> prayerTimes;
  final String errorMessageofPrayerTimes;
  final RequestStateEnum requestStateofPrayerTimes;
  final NextPrayer nextPrayer;

  PrayerTimesState copyWith(
      {List<String>? prayerTimes,
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
