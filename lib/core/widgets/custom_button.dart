import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

MaterialButton customButton(
    {required CustomButtonInputModel customButtonInputModel}) {
  return MaterialButton(
    onPressed: customButtonInputModel.onPressedFunction,
    height: customButtonInputModel.context.height * 0.06,
    minWidth: customButtonInputModel.context.width * 0.8,
    color: AppColors.primaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Text(customButtonInputModel.buttonName,
        style: TextStyles.semiBold32(customButtonInputModel.context,
            color: AppColors.black)),
  );
}

class CustomButtonInputModel {
  final BuildContext context;
  final String buttonName;
  final VoidCallback onPressedFunction;

  CustomButtonInputModel(
      {required this.context,
      required this.buttonName,
      required this.onPressedFunction});
}
