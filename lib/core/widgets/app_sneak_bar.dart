import 'package:flutter/material.dart';
import 'package:test_app/core/helper_function/get_responsive_font_size.dart';
import 'package:test_app/core/theme/app_colors.dart';

appSneakBar(
        {required BuildContext context,
        required String message,
        required bool isError}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: isError ? AppColors.inActiveThirdColor : AppColors.primaryColor,
      content: Center(
          child: Text(
        message,
        style: TextStyle(
            color: isError ? AppColors.thirdColor : AppColors.white,
            fontSize: getResponsiveFontSize(
              context: context,
              fontSize: 20,
            ),
            fontWeight: FontWeight.bold),
      )),
    ));
