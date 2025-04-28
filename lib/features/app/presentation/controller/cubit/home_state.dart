part of 'home_cubit.dart';

class HomeState extends Equatable {
  final Timings? prayerTimes;
  final String errorMessageofPrayerTimes;
  final RequestStateEnum requestStateofPrayerTimes;
  final PrayerTime? prayerTime;
  final double width;
  final bool isVisible;
  final double opacity;

  const HomeState(
      {this.prayerTimes,
      this.prayerTime,
      this.opacity = 0.0,
      this.width = 0.0,
      this.isVisible = false,
      this.errorMessageofPrayerTimes = '',
      this.requestStateofPrayerTimes = RequestStateEnum.loading});

  HomeState copyWith({
    Timings? prayerTimes,
    String? errorMessageofPrayerTimes,
    RequestStateEnum? requestStateofPrayerTimes,
    PrayerTime? prayerTime,
    double? width,
    double? opacity,
    bool? isVisible,
  }) {
    return HomeState(
      errorMessageofPrayerTimes:
          errorMessageofPrayerTimes ?? this.errorMessageofPrayerTimes,
      prayerTime: prayerTime ?? this.prayerTime,
      prayerTimes: prayerTimes ?? this.prayerTimes,
      requestStateofPrayerTimes:
          requestStateofPrayerTimes ?? this.requestStateofPrayerTimes,
      width: width ?? this.width,
      opacity: opacity ?? this.opacity,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  List<Object?> get props => [
        prayerTimes,
        errorMessageofPrayerTimes,
        requestStateofPrayerTimes,
        prayerTime,
        opacity,
        width,
        isVisible,
      ];
}
