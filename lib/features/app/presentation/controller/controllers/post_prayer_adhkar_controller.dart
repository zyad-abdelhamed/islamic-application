import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/constants/app_strings.dart';

class PostPrayerAdhkarController {
  late final ValueNotifier<int> progressNotifier;
  final List _tsabeehList = AppStrings.translate("adhkarList");

  initState() {
    progressNotifier = ValueNotifier<int>(0);
  }

  void dispose() {
    progressNotifier.dispose();
  }

  void drawCircle(BuildContext context) {
    if (progressNotifier.value == 32 ||
        progressNotifier.value == 65 ||
        progressNotifier.value == 98) {
      progressNotifier.value += 2;
      return;
    } else if (progressNotifier.value == 100) {
      progressNotifier.value += 3;
      Future.delayed(AppDurations.mediumDuration, () => Navigator.pop(context));
    }
    progressNotifier.value += 1;
  }

  String get getText {
    if (progressNotifier.value < 34) {
      return _tsabeehList[0];
    } else if (progressNotifier.value >= 34 && progressNotifier.value < 67) {
      return _tsabeehList[1];
    } else if (progressNotifier.value >= 67 && progressNotifier.value < 100) {
      return _tsabeehList[2];
    }
    return _tsabeehList[3];
  }
}
