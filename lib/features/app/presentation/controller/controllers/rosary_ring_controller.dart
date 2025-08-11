import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/constants/app_strings.dart';

class RosaryRingController {
  final ValueNotifier<double> progressNotifier = ValueNotifier(0);

  int selectedIndex = 0;

  void dispose() => progressNotifier.dispose();

  void drawRosaryRing(BuildContext context) {
    progressNotifier.value += 1;

    if (progressNotifier.value == 3) {
      selectedIndex += 1;
      Future.delayed(AppDurations.mediumDuration, () {
        progressNotifier.value = 0;

        if (selectedIndex == AppStrings.translate("adhkarList").length) {
          Future.delayed(AppDurations.longDuration, () {
            Navigator.pop(context);
          });
        }
      });
    }
  }

  String get getRingText {
    if (selectedIndex < AppStrings.translate("adhkarList").length) {
      return AppStrings.translate("adhkarList")[selectedIndex];
    }
    return AppStrings.translate("done");
  }

  Color getContainerColor(BuildContext context, int index) {
    return selectedIndex > index
        ? Theme.of(context).primaryColor
        : Colors.transparent;
  }
}
