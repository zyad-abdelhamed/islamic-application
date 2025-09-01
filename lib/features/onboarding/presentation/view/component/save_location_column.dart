import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/onboarding/presentation/view/component/save_location_button.dart';

List<Widget> saveLocationColumn(BuildContext context) {
  return <Widget>[
    // النص التوضيحي
    Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        AppStrings.translate("saveLocationHintText"),
        textAlign: TextAlign.center,
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
