import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/timer/cubit/timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit()
      : super(const TimerState(hours: 0, minutes: 0, seconds: 0));
  Timer? _timer;
  void startTimerUntil(String targetTime) {
     print("🕒 بدأ العد التنازلي حتى: $targetTime");
    Duration remaining = _calculateRemainingTime(targetTime);
    DateTime now = DateTime.now();

    //طباعة التوقيت بنظام 24 ساعة
    String formattedTime =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";

    startTimer(
        remaining.inHours, remaining.inMinutes % 60, remaining.inSeconds % 60);
  }

  void startTimer(int hours, int minutes, int seconds) {
    emit(state.copyWith(
        hours: hours, minutes: minutes, seconds: seconds, isRunning: true));

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentState = state;
        print('🕒 تحديث العد التنازلي: ${currentState.hours}:${currentState.minutes}:${currentState.seconds}');

      if (currentState.hours == 0 &&
          currentState.minutes == 0 &&
          currentState.seconds == 0) {
        timer.cancel();
        emit(currentState.copyWith(isRunning: false));
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

  // 🔹 دالة لحساب الوقت المتبقي حتى وقت معين
  Duration _calculateRemainingTime(String targetTime) {
    List<String> parts = targetTime.split(":");
    if (parts.length != 3) return Duration.zero;

    int hours = int.tryParse(parts[0]) ?? 0;
    int minutes = int.tryParse(parts[1]) ?? 0;
    int seconds = int.tryParse(parts[2]) ?? 0;

    DateTime now = DateTime.now();
    DateTime targetDateTime =
        DateTime(now.year, now.month, now.day, hours, minutes, seconds);

    // إذا كان الوقت المستهدف قد مر، أضف يومًا ليصبح في الغد
    if (targetDateTime.isBefore(now)) {
      targetDateTime = targetDateTime.add(const Duration(days: 1));
    }

    return targetDateTime.difference(now);
  }

  void stopTimer() {
    //dispose
    _timer?.cancel();
    emit(state.copyWith(isRunning: false));
  }
}
