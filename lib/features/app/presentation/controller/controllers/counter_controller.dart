import 'package:flutter/material.dart';
import 'package:test_app/core/utils/extentions/media_query_extention.dart';
import 'package:test_app/features/app/presentation/view/components/counter_widget.dart';
import 'package:test_app/features/app/presentation/view/components/featured_records_widget.dart';
import 'package:test_app/features/app/presentation/view/components/rolling_counter.dart';
import 'package:vibration/vibration.dart';

class CounterController {
  CounterController(ValueNotifier<bool> notifier) {
    scaleNotifier = ValueNotifier(1.0);
    vibrationNotifier = ValueNotifier<bool>(true);
    counterKey = GlobalKey<RollingCounterState>();
    isfeatuerdRecordsWidgetShowedNotifier = notifier;
  }

  late final ValueNotifier<double> scaleNotifier;
  late final ValueNotifier<bool> vibrationNotifier;
  late final GlobalKey<RollingCounterState> counterKey;
  late final ValueNotifier<bool> isfeatuerdRecordsWidgetShowedNotifier;

  void dispose() {
    vibrationNotifier.dispose();
  }

  double get getMargine => isfeatuerdRecordsWidgetShowedNotifier.value
      ? featuerdRecordsWidgetHight + showedFeatuerdRecordsWidgetButtonHight
      : counterWidetDefaultMargin;

  double horizontalPadding(BuildContext context) {
    return !isfeatuerdRecordsWidgetShowedNotifier.value
        ? 10.0
        : (context.width * 1 / 3) * 1 / 2;
  }

  double increaseButtonSize(BuildContext context) => context.isLandScape
      ? (context.height) - (100 + 100 + 20 + 15)
      : !isfeatuerdRecordsWidgetShowedNotifier.value
          ? ((context.width - 20))
          : (context.width * 2 / 3) * .70;

  void increaseCounter() {
    counterKey.currentState?.increase(-1.0);
  }

  void resetCounter() {
    counterKey.currentState?.reset(0);
  }

  void onTapDown() async {
    if (vibrationNotifier.value) {
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 20, amplitude: 130);
      }
    }
    scaleNotifier.value = 0.9;
  }

  void onTapUp() async {
    if (vibrationNotifier.value) {
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 30, amplitude: 200);
      }
    }
    scaleNotifier.value = 1.0;
    increaseCounter();
  }
}
