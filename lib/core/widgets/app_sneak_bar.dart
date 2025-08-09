import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

appSneakBar({
  required BuildContext context,
  required String message,
  String? label,
  void Function()? onPressed,
  required bool isError,
}) {
  final backgroundColor = isError
      ? AppColors.inActiveErrorColor
      : AppColors.successColor;

  final textColor = isError ? AppColors.errorColor : AppColors.white;

  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: label == null
          ? const Duration(seconds: 4)
          : const Duration(seconds: 8),
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              isError ? Icons.warning_amber_rounded : Icons.check_circle,
              color: textColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyles.regular16_120(context, color: textColor),
              ),
            ),
            if (label != null)
              TextButton(
                onPressed: onPressed ?? () {},
                child: Text(
                  label,
                  style: TextStyles.semiBold16(
                    context: context,
                    color: AppColors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}
