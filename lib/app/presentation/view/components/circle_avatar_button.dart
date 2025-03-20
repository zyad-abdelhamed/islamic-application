import 'package:flutter/material.dart';
import 'package:test_app/core/helper_function/get_responsive_font_size.dart';
import 'package:test_app/core/theme/app_colors.dart';

GestureDetector circleAvatarButton(
        {required BuildContext context,
        required IconData icon,
        required VoidCallback function}) =>
    GestureDetector(
      onTap: function,
      child: CircleAvatar(
        backgroundColor: AppColors.inActivePrimaryColor,
        radius: getResponsiveFontSize(context: context, fontSize: 37),
        child: Icon(
          icon,
          size: getResponsiveFontSize(context: context, fontSize: 40),color: AppColors.primaryColor,
        ),
      ),
    );