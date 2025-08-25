import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';

class NumberAnimationModel {
  int number;
  final Offset? offset;
  final bool? offStage;

  NumberAnimationModel(
      {required this.number, this.offset = Offset.zero, this.offStage = false});

  void slideAnimation(
      {required ValueNotifier<NumberAnimationModel> notifier,
      required double slideValue,
      required int newValue}) {
    notifier.value = NumberAnimationModel(
        number: notifier.value.number,
        offset: Offset(0, slideValue),
        offStage: true);
    //start animation

    Future.delayed(AppDurations.lowDuration, () {
      notifier.value = NumberAnimationModel(number: newValue);
    }); //reverse animation and stop
  }
}
