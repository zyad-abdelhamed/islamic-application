import 'package:equatable/equatable.dart';

// 🔹 حالة المؤقت
class TimerState extends Equatable {
  final int hours;
  final int minutes;
  final int seconds;
  final bool isRunning;

  const TimerState(
      {required this.hours,
      required this.minutes,
      required this.seconds,
      this.isRunning = false});

  @override
  List<Object> get props => [hours, minutes, seconds, isRunning];

  TimerState copyWith(
      {int? hours, int? minutes, int? seconds, bool? isRunning}) {
    return TimerState(
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
      isRunning: isRunning ?? this.isRunning,
    );
  }
}
