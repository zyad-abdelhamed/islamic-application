import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/constants/constants_values.dart';
import 'package:test_app/core/theme/app_colors.dart';
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

  TextStyle get dataTextStyle {
    return const TextStyle(
        color: AppColors.white,
        fontFamily: 'Amiri',
        fontSize: 20.0,
        fontWeight: FontWeight.bold);
  }

  BoxDecoration highlightBoxDecoration(BuildContext context, int i) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color:
          context.read<NextPrayerController>().nextPrayerNotifier.value.name ==
                  names[i]
              ? AppColors.darkModeInActiveColor
              : Colors.transparent,
    );
  }

  BoxDecoration boxDecoration({required Color color}) {
    return BoxDecoration(
      borderRadius:
          BorderRadius.circular(ConstantsValues.prayerTimesWidgetBorderRadius),
      color: color,
    );
  }
}
