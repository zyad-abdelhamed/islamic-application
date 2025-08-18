import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/constants/app_strings.dart';

class RosaryRingController {
  late final ValueNotifier<int> progressNotifier;

  late final ValueNotifier<int> selectedIndexNotifier;

  final int _maxProgress = 18;
  final int _progressStepValue = 6; // (18 / 3)
  final List tsabeehList = AppStrings.translate("adhkarList");

  void initState() {
    progressNotifier = ValueNotifier(0);
    selectedIndexNotifier = ValueNotifier(0);
    selectedIndexNotifier.addListener(
      () {},
    );
  }

  void dispose() {
    progressNotifier.dispose();
    selectedIndexNotifier.dispose();
  }

  void drawRosaryRing(BuildContext context) {
    if (selectedIndexNotifier.value < tsabeehList.length) {
      progressNotifier.value += _progressStepValue;

      if (progressNotifier.value == _maxProgress) {
        selectedIndexNotifier.value += 1;
        Future.delayed(AppDurations.mediumDuration, () {
          progressNotifier.value = 0;

          if (selectedIndexNotifier.value == tsabeehList.length) {
            Future.delayed(
                AppDurations.mediumDuration, () => Navigator.pop(context));
          }
        });
      }
    }
    return;
  }

  String get getRingText {
    if (selectedIndexNotifier.value < tsabeehList.length) {
      return tsabeehList[selectedIndexNotifier.value];
    }
    return AppStrings.translate("done");
  }

  Color getContainerColor(BuildContext context, int index) {
    return selectedIndexNotifier.value > index
        ? Theme.of(context).primaryColor
        : Colors.transparent;
  }
}
