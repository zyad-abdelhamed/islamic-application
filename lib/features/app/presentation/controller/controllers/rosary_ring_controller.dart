import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/constants/app_strings.dart';

class RosaryRingController {
  final ValueNotifier<int> progressNotifier = ValueNotifier(0);

  final ValueNotifier<int> selectedIndex = ValueNotifier(0);

  void dispose() {progressNotifier.dispose();selectedIndex.dispose();}

  void drawRosaryRing(BuildContext context) {
    progressNotifier.value += 1;

    if (progressNotifier.value == 3) {
      selectedIndex.value += 1;
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
    if (selectedIndex.value < AppStrings.translate("adhkarList").length) {
      return AppStrings.translate("adhkarList")[selectedIndex.value];
    }
    return AppStrings.translate("done");
  }

  Color getContainerColor(BuildContext context, int index) {
    return selectedIndex.value > index
        ? Theme.of(context).primaryColor
        : Colors.transparent;
  }
}
