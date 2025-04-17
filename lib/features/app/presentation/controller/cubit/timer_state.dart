import 'package:equatable/equatable.dart';
import 'package:test_app/features/app/domain/entities/next_prayer_entity.dart';
import 'package:test_app/core/utils/enums.dart';

// 🔹 حالة المؤقت
class TimerState extends Equatable {
  final NextPrayerEntity? nextPrayer;
  final RequestStateEnum? nextPrayerRequestState;
  final String? nextPrayerError;
  final int hours;
  final int minutes;
  final int seconds;
  final bool isRunning;

  const TimerState({
    required this.hours,
    required this.minutes,
    required this.seconds,
    this.isRunning = false,
    this.nextPrayer,
    this.nextPrayerRequestState = RequestStateEnum.loading,
    this.nextPrayerError,
  });

  TimerState copyWith(
      {int? hours,
      int? minutes,
      int? seconds,
      bool? isRunning,
      NextPrayerEntity? nextPrayer,
      RequestStateEnum? nextPrayerRequestState,
      String? nextPrayerError}) {
    return TimerState(
      nextPrayer: nextPrayer ?? this.nextPrayer,
      nextPrayerRequestState:
          nextPrayerRequestState ?? this.nextPrayerRequestState,
      nextPrayerError: nextPrayerError ?? this.nextPrayerError,
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
      isRunning: isRunning ?? this.isRunning,
    );
  }

  @override
  List<Object?> get props => [
        hours,
        minutes,
        seconds,
        isRunning,
        nextPrayer,
        nextPrayerRequestState,
        nextPrayerError
      ];
}
