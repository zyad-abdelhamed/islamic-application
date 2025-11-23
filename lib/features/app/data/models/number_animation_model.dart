import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';

class NumberAnimationModel {
  final List<DigitAnimationModel> digits;

  const NumberAnimationModel({required this.digits});

  /// تحليل الرقم إلى digits بدون أصفار على الشمال
  static NumberAnimationModel fromInt(int number) {
    final str = number.toString(); // بدون padLeft
    final digits = str
        .split('')
        .reversed
        .map((d) => DigitAnimationModel(digit: int.parse(d)))
        .toList();

    return NumberAnimationModel(digits: digits);
  }

  /// تطبيق الأنيميشن على الأرقام اللي اتغيرت بس
  void slideAnimation({
    required ValueNotifier<NumberAnimationModel> notifier,
    required double slideValue,
    required int newValue,
  }) {
    final oldDigits = notifier.value.digits;
    final newDigits = NumberAnimationModel.fromInt(newValue).digits;

    final maxLength = (oldDigits.length > newDigits.length)
        ? oldDigits.length
        : newDigits.length;

    final animatedDigits = <DigitAnimationModel>[];

    for (int i = 0; i < maxLength; i++) {
      final oldDigit = (i < oldDigits.length) ? oldDigits[i].digit : null;
      final newDigit = (i < newDigits.length) ? newDigits[i].digit : null;

      if (oldDigit != newDigit) {
        // رقم اتغير → عمل الانيميشن
        animatedDigits.add(
          DigitAnimationModel(
            digit: oldDigit ?? newDigit ?? 0,
            offset: Offset(0, slideValue),
            offStage: true,
          ),
        );
      } else {
        animatedDigits.add(
          DigitAnimationModel(digit: oldDigit ?? newDigit ?? 0),
        );
      }
    }

    notifier.value = NumberAnimationModel(digits: animatedDigits);

    Future.delayed(AppDurations.lowDuration, () {
      notifier.value = NumberAnimationModel(digits: newDigits);
    });
  }
}

class DigitAnimationModel {
  final int digit;
  final Offset offset;
  final bool offStage;
  const DigitAnimationModel({
    required this.digit,
    this.offset = Offset.zero,
    this.offStage = false,
  });
  DigitAnimationModel copyWith({
    int? digit,
    Offset? offset,
    bool? offStage,
  }) {
    return DigitAnimationModel(
      digit: digit ?? this.digit,
      offset: offset ?? this.offset,
      offStage: offStage ?? this.offStage,
    );
  }
}
