import 'package:flutter/material.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/data/models/number_animation_model.dart';
import 'package:test_app/features/app/presentation/view/components/counter_widget.dart';
import 'package:test_app/features/app/presentation/view/components/featured_records_widget.dart';
import 'package:vibration/vibration.dart';

class CounterController {
  CounterController(ValueNotifier<bool> notifier) {
    scaleNotifier = ValueNotifier(1.0);
    vibrationNotifier = ValueNotifier<bool>(true);
    counterNotifier = ValueNotifier(NumberAnimationModel(number: 0));
    isfeatuerdRecordsWidgetShowedNotifier = notifier;
  }

  late final ValueNotifier<double> scaleNotifier;
  late final ValueNotifier<bool> vibrationNotifier;
  late final ValueNotifier<NumberAnimationModel> counterNotifier;
  late final ValueNotifier<bool> isfeatuerdRecordsWidgetShowedNotifier;

  dispose() {
    vibrationNotifier.dispose();
    counterNotifier.dispose();
  }

  double get getMargine => isfeatuerdRecordsWidgetShowedNotifier.value
      ? featuerdRecordsWidgetHight + showedFeatuerdRecordsWidgetButtonHight
      : counterWidetDefaultMargin;

  double horizontalPadding(BuildContext context) {
    return !isfeatuerdRecordsWidgetShowedNotifier.value
        ? 10.0
        : (context.width * 1 / 3) * 1 / 2;
  }

  double increaseButtonSize(BuildContext context) =>
      !isfeatuerdRecordsWidgetShowedNotifier.value
          ? ((context.width - 20))
          : (context.width * 2 / 3) * .70;

  void increaseCounter() {
    counterNotifier.value.slideAnimation(
      notifier: counterNotifier,
      slideValue: -.7,
      newValue: counterNotifier.value.number + 1,
    );
  }

  void resetCounter() {
    if (counterNotifier.value.number != 0) {
      counterNotifier.value.slideAnimation(
        notifier: counterNotifier,
        slideValue: .7,
        newValue: 0,
      );
    }

    return;
  }

  void onTapDown({required ValueNotifier<double> scaleNotifier}) async {
    if (vibrationNotifier.value) {
      print('vibration');
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 20, amplitude: 130);
      }
    }
    scaleNotifier.value = 0.9;
  }

  void onTapUp({required ValueNotifier<double> scaleNotifier}) async {
    if (vibrationNotifier.value) {
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 30, amplitude: 200);
      }
    }
    scaleNotifier.value = 1.0;
    increaseCounter();
  }
}
