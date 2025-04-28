import 'package:flutter/material.dart';
import 'package:test_app/core/helper_function/get_responsive_font_size.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class AdhkarButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final IconData icon;
  const AdhkarButton(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.inActivePrimaryColor,
            borderRadius: BorderRadius.circular(50)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.primaryColor,
              size: getResponsiveFontSize(context: context, fontSize: 60),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyles.semiBold18(context, AppColors.primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}