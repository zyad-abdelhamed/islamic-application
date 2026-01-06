import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/extentions/theme_extention.dart';

class CancelButton extends StatelessWidget {
  final VoidCallback onTap;

  const CancelButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.close, color: AppColors.errorColor, size: 16),
            const SizedBox(width: 4),
            Text(
              AppStrings.translate("cancel"),
              style: context.bodyMedium.copyWith(
                color: AppColors.errorColor,
                fontSize: Theme.of(context).iconTheme.size,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
