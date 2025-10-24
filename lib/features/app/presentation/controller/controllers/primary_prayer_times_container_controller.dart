import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/constants/constants_values.dart';
import 'package:test_app/features/app/presentation/controller/controllers/next_prayer_controller.dart';

class PrimaryPrayerTimesContainerController {
  PrimaryPrayerTimesContainerController() {
    names = AppStrings.translate("namesOfPrayers1");
    icons = AppStrings.translate("iconsOfTimings");
  }

  static PrimaryPrayerTimesContainerController get instance =>
      PrimaryPrayerTimesContainerController();

  late final List names;
  late final List icons;

  TextStyle dataTextStyle(BuildContext context, int i) {
    return TextStyle(
        color: Colors.white,
        fontFamily: 'Amiri',
        fontSize: 20.0,
        fontWeight: FontWeight.bold);
  }

  Null get timings => null;

  BoxDecoration highlightBoxDecoration(BuildContext context, int i) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      color:
          context.read<NextPrayerController>().nextPrayerNotifier.value.name ==
                  names[i]
              ? (Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white)
                  .withOpacity(0.2)
              : Colors.transparent,
    );
  }

  BoxDecoration boxDecoration({required Color color}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(ConstantsValues.cardBorderRadius),
      color: color,
    );
  }
}
