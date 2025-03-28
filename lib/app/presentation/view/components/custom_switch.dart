import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class CustomSwitch extends StatelessWidget {
  final String title;
  final MainAxisAlignment mainAxisAlignment;
  final Function(bool)? onChanged;
  final bool value;
  const CustomSwitch({
    super.key,
    required this.title, required this.mainAxisAlignment, required this.onChanged, required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.0,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(
          title,
          style: TextStyles.bold20(context),
        ),
        Switch(
          activeColor: AppColors.thirdColor,
          activeTrackColor: AppColors.thirdColor.withValues(alpha: .8),
          inactiveThumbColor: AppColors.black,
          inactiveTrackColor: AppColors.inActiveBlackColor,
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
