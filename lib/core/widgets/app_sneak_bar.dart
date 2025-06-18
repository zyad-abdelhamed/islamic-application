import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

appSneakBar(
        {required BuildContext context,
        required String message,
        String? label,
        void Function()? onPressed,
        required bool isError}) =>
    ScaffoldMessenger.of(context).showSnackBar(label == null
        ? SnackBar(
            backgroundColor:
                isError ? AppColors.inActiveThirdColor : AppColors.primaryColor,
            content: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyles.regular16_120(context,
                  color: isError ? AppColors.thirdColor : AppColors.white),
            ),
          )
        : SnackBar(
            duration: const Duration(seconds: 8),
            backgroundColor:
                isError ? AppColors.inActiveThirdColor : AppColors.primaryColor,
            content: Text(
              message,
              style: TextStyles.regular16_120(context,
                  color: isError ? AppColors.thirdColor : AppColors.white),
            ),
            action: SnackBarAction(
                label: label,
                textColor: AppColors.primaryColor,
                onPressed: onPressed ?? () {}),
          ));
