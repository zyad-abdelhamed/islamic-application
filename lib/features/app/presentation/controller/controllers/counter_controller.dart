import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/data/models/number_animation_model.dart';
import 'package:test_app/features/app/presentation/view/components/counter_widget.dart';
import 'package:test_app/features/app/presentation/view/components/featured_records_widget.dart';

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
    slideAnimation(slideValue: -.7, newValue: counterNotifier.value.number + 1);
  }

  void resetCounter() {
    if (counterNotifier.value.number != 0) {
      slideAnimation(slideValue: .7, newValue: 0);
    }

    return;
  }

  void slideAnimation({required double slideValue, required int newValue}) {
    counterNotifier.value = NumberAnimationModel(
        number: counterNotifier.value.number,
        offset: Offset(0, slideValue),
        opacity: 0.0);
    //start animation

    Future.delayed(AppDurations.lowDuration, () {
      counterNotifier.value = NumberAnimationModel(number: newValue);
    }); //reverse animation and stop
  }

  void onTapDown({required ValueNotifier<double> scaleNotifier}) {
    if (vibrationNotifier.value) {
      HapticFeedback.selectionClick();
    }
    scaleNotifier.value = 0.9;
  }

  void onTapUp({required ValueNotifier<double> scaleNotifier}) {
    if (vibrationNotifier.value) {
      HapticFeedback.lightImpact();
    }
    scaleNotifier.value = 1.0;
    increaseCounter();
  }
}
