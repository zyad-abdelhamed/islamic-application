import 'dart:async';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(const TimerState(hours: 0, minutes: 0, seconds: 0));
  Timer? _timer;
  VoidCallback? onTimerFinished;

  // المتغير لحفظ الوقت المتبقي للصلاة القادمة
  int? lastHours;
  int? lastMinutes;
  int? lastSeconds;

  // دالة لبدء التايمر حتى وقت الصلاة المحدد
  void startTimerUntil(String targetTime) {
    Duration remaining = _calculateRemainingTime(targetTime);
    startTimer(
        remaining.inHours, remaining.inMinutes % 60, remaining.inSeconds % 60);
  }

  // دالة لبدء التايمر من الساعات والدقائق والثواني المحددة
  void startTimer(int hours, int minutes, int seconds) {
    int startHours = lastHours ?? hours;
    int startMinutes = lastMinutes ?? minutes;
    int startSeconds = lastSeconds ?? seconds;

    emit(state.copyWith(
        hours: startHours, minutes: startMinutes, seconds: startSeconds, isRunning: true));

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentState = state;

      if (currentState.hours == 0 &&
          currentState.minutes == 0 &&
          currentState.seconds == 0) {
        timer.cancel();
        emit(currentState.copyWith(isRunning: false));
        if (onTimerFinished != null) {
          onTimerFinished!();
        }
      } else {
        int newHours = currentState.hours;
        int newMinutes = currentState.minutes;
        int newSeconds = currentState.seconds - 1;

        if (newSeconds < 0) {
          newSeconds = 59;
          newMinutes--;
        }
        if (newMinutes < 0) {
          newMinutes = 59;
          newHours--;
        }

        emit(state.copyWith(
            hours: newHours,
            minutes: newMinutes,
            seconds: newSeconds,
            isRunning: true));
      }
    });
  }

  Duration _calculateRemainingTime(String targetTime) {
    List<String> parts = targetTime.split(":");
    if (parts.length != 3) return Duration.zero;

    int hours = int.tryParse(parts[0]) ?? 0;
    int minutes = int.tryParse(parts[1]) ?? 0;
    int seconds = int.tryParse(parts[2]) ?? 0;

    DateTime now = DateTime.now();
    DateTime targetDateTime =
        DateTime(now.year, now.month, now.day, hours, minutes, seconds);

    if (targetDateTime.isBefore(now)) {
      targetDateTime = targetDateTime.add(const Duration(days: 1));
    }

    return targetDateTime.difference(now);
  }

  // إيقاف التايمر وحفظ الوقت المتبقي
  void stopTimer() {
    final currentState = state;
    lastHours = currentState.hours;
    lastMinutes = currentState.minutes;
    lastSeconds = currentState.seconds;

    _timer?.cancel();
    emit(state.copyWith(isRunning: false));
  }
}
