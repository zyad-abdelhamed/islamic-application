part of 'get_prayer_times_of_month_cubit.dart';

class GetPrayerTimesOfMonthState extends Equatable {
  const GetPrayerTimesOfMonthState({
    this.getPrayerTimesOfMonthState,
    this.prayerTimesOfMonth = const [],
    this.getPrayerTimesOfMonthErrorMeassage
  });

  final RequestStateEnum? getPrayerTimesOfMonthState;
  final List<Timings> prayerTimesOfMonth;
  final String? getPrayerTimesOfMonthErrorMeassage;

  @override
  List<Object?> get props => [
    getPrayerTimesOfMonthState,
    prayerTimesOfMonth,
    getPrayerTimesOfMonthErrorMeassage
  ];
}
