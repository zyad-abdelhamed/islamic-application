import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class AdaptiveSwitch extends StatelessWidget {
  const AdaptiveSwitch(
      {super.key,
      required this.name,
      required this.onChanged,
      required this.value,
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween});

  final String name;
  final void Function(bool value) onChanged;
  final bool value;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(
          name,
          style: TextStyles.bold20(context).copyWith(
            fontSize: 16,
            fontFamily: 'Cairo',
          ),
        ),
        const SizedBox(width: 12),
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
          trackOutlineWidth: WidgetStatePropertyAll(0.0),
          activeThumbColor: Colors.white,
          activeTrackColor: AppColors.successColor,
          inactiveThumbColor: AppColors.grey400,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }
}
