import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/constants/app_strings.dart';

class PostPrayerAdhkarController {
  late final ValueNotifier<int> progressNotifier;
  late final ValueNotifier<String> text;

  initState() {
    progressNotifier = ValueNotifier<int>(0);
    text = ValueNotifier<String>(AppStrings.translate("adhkarList")[0]);
    progressNotifier.addListener(() {
      if (progressNotifier.value == 34) {
        text.value = AppStrings.translate("adhkarList")[1];
      }
      if (progressNotifier.value == 67) {
        text.value = AppStrings.translate("adhkarList")[2];
      }
      if (progressNotifier.value == 100) {
        text.value = AppStrings.translate("adhkarList")[3];
      }
    });
  }

  void dispose() {
    progressNotifier.dispose();
    text.dispose();
  }

  void drawCircle(BuildContext context) {
    if (progressNotifier.value == 32 ||
        progressNotifier.value == 65 ||
        progressNotifier.value == 98) {
      progressNotifier.value += 2;
      return;
    } else if (progressNotifier.value == 100) {
      progressNotifier.value += 3;
      Future.delayed(AppDurations.mediumDuration,() => Navigator.pop(context));
    }
    progressNotifier.value += 1;
  }
}
