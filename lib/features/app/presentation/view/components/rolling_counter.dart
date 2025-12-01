import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/services/arabic_converter_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/app/data/models/number_animation_model.dart';

class RollingCounter extends StatefulWidget {
  final int initialNumber;
  final Duration duration;
  final TextStyle textStyle;

  const RollingCounter({
    super.key,
    required this.initialNumber,
    this.duration = AppDurations.lowDuration,
    required this.textStyle,
  });

  @override
  RollingCounterState createState() => RollingCounterState();
}

class RollingCounterState extends State<RollingCounter> {
  late ValueNotifier<NumberAnimationModel> notifier;
  late int currentNumber;

  @override
  void initState() {
    super.initState();
    currentNumber = widget.initialNumber;
    notifier = ValueNotifier(
      NumberAnimationModel.fromInt(currentNumber),
    );
  }

  void set(int newValue, {required double slideValue}) {
    if (newValue == currentNumber) return;
    notifier.value.slideAnimation(
      notifier: notifier,
      slideValue: slideValue,
      newValue: newValue,
    );
    currentNumber = newValue;
  }

  void increase(double slideValue) =>
      set(currentNumber + 1, slideValue: slideValue);

  void decrease(double slideValue) =>
      set(currentNumber - 1, slideValue: slideValue);

  void reset(int to) => set(to, slideValue: 0.0);

  int get value => currentNumber;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<NumberAnimationModel>(
      valueListenable: notifier,
      builder: (_, NumberAnimationModel model, __) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: model.digits.map((DigitAnimationModel digitModel) {
            final String digit = sl<BaseArabicConverterService>()
                .convertToArabicDigits(digitModel.digit.toString());
            return AnimatedSlide(
              offset: digitModel.offset,
              duration: widget.duration,
              child: Visibility.maintain(
                visible: !digitModel.offStage,
                child: Text(
                  digit,
                  style: widget.textStyle,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }
}
