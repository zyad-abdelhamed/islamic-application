import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';

Widget isServiceEnabledWidget({
  required bool isActive,
  required IconData activeIcon,
  required IconData inactiveIcon,
  required String activeText,
  required String inactiveText,
}) {
  return Column(
    children: [
      Icon(
        isActive ? activeIcon : inactiveIcon,
        color: isActive ? AppColors.successColor : AppColors.errorColor,
      ),
      Text(
        isActive ? activeText : inactiveText,
        style: TextStyle(
          fontSize: 16,
          color: isActive ? AppColors.successColor : AppColors.errorColor,
        ),
      ),
    ],
  );
}
