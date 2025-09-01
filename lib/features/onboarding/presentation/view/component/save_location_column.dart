import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/onboarding/presentation/view/component/save_location_button.dart';

List<Widget> saveLocationColumn(BuildContext context) {
  return <Widget>[
    // العنوان
    Text(
      "• خطوة أخرى",
      style: TextStyles.semiBold32(
        context,
        color: ThemeCubit.controller(context).state
            ? AppColors.darkModeTextColor
            : AppColors.lightModePrimaryColor,
      ),
    ),

    const SizedBox(height: 12), // مسافة أكبر تحت العنوان

    // النص التوضيحي
    Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        AppStrings.translate("saveLocationHintText"),
        style: TextStyles.semiBold16_120(context).copyWith(
          color: AppColors.secondryColor,
          fontFamily: "DataFontFamily",
          height: 1.5, // تحسين تباعد الأسطر
        ),
      ),
    ),
    SaveLocationButton()
  ];
}
