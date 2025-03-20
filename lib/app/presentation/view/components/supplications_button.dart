import 'package:flutter/material.dart';
import 'package:test_app/core/helper_function/get_responsive_font_size.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class SupplicationsButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final IconData icon;
  const SupplicationsButton(
      {super.key, required this.icon, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    final double supplicationsButtonWidth = ((context.width) -
            (16 //parent padding from left and right
                +
                40 //space between two buttons
            )) /
        2; //two buttons in one row
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 20//todo
        , bottom: 40),
        width: supplicationsButtonWidth,
        height: supplicationsButtonWidth, //same value of the width
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(blurRadius: 6, color: AppColors.inActivePrimaryColor)
            ],
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
