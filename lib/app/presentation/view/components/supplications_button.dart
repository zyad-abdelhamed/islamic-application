import 'package:flutter/material.dart';
import 'package:test_app/core/helper_function/get_responsive_font_size.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class SupplicationsButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final IconData icon;
  final double horizontalSpacing;
  const SupplicationsButton(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.text,
      required this.horizontalSpacing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
            left: horizontalSpacing, //horizontal spacing between two buttons
            bottom: 20 //vertical spacing between two buttons
            ),
        width: _getSupplicationsButtonWidth(context),
        height: _getSupplicationsButtonWidth(context), //same value of the width
        decoration: BoxDecoration(
            color: AppColors.inActivePrimaryColor,
            borderRadius: BorderRadius.circular(50)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.primaryColor,
              size: getResponsiveFontSize(context: context, fontSize: 80),
            ),
            Text(
              text,
              style: TextStyles.semiBold18(context, AppColors.primaryColor),
            )
          ],
        ),
      ),
    );
  }
}

double _getSupplicationsButtonWidth(BuildContext context) {
  return ((context.width) -
          (16 //parent padding from left and right
              +
              20 //space between two buttons
          )) /
      2; //two buttons in one row
}
