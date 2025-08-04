import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class AdaptiveSwitch extends StatelessWidget {
  const AdaptiveSwitch({
    super.key,
    required this.name,
    required this.onChanged,
    required this.value,
  });

  final String name;
  final void Function() onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
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
          onChanged: (_) => onChanged(),
          activeColor: AppColors.grey400,
          activeTrackColor: AppColors.successColor,
          inactiveThumbColor: AppColors.grey400,
          inactiveTrackColor: AppColors.grey.withValues(alpha: 0.4),
          trackOutlineColor: WidgetStatePropertyAll(AppColors.grey400),
          splashRadius: 20,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }
}
