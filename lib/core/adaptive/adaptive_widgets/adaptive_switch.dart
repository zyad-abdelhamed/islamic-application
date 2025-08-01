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
        spacing: 10.0,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: TextStyles.bold20(context).copyWith(fontSize: 18),
          ),
          Switch.adaptive(
              thumbColor: WidgetStatePropertyAll(AppColors.white),
              activeTrackColor: AppColors.secondryColor,
              trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
              inactiveTrackColor: Colors.grey,
              value: value,
              onChanged: (bool value) => onChanged)
        ]);
  }
}
