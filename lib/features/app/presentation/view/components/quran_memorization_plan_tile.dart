import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/widgets/app_divider.dart';

class QuranMemorizationPlanTile extends StatelessWidget {
  final String title;
  final Widget? leading, trailing;
  final double progress;
  final void Function()? onTap;

  const QuranMemorizationPlanTile({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    required this.progress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double leadingSize = leading != null ? 56.0 : 0.0;

    return Column(
      children: [
        Row(
          spacing: 8.0,
          children: [
            SizedBox(
              height: leadingSize,
              width: leadingSize,
              child: leading,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(title),
                trailing: trailing,
                onTap: onTap,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            right: leading != null ? 56.0 + 8.0 : 0.0,
            bottom: 8.0,
          ),
          child: leading != null
              ? const AppDivider()
              : LinearProgressIndicator(
                  value: progress,
                  color: AppColors.primaryColor,
                  backgroundColor: AppColors.primaryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(16.0),
                ),
        ),
      ],
    );
  }
}
