import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

ElevatedButton onBoardingButton(
    {required BuildContext context,
    required String name,
    required VoidCallback onPressed}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.thirdColor),
      onPressed: onPressed,
      child: Text(
        name,
        style: TextStyles.semiBold16(context: context, color: AppColors.white),
      ));
}
