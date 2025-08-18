import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

void showInfoSnackBar({
  required BuildContext context,
  required String message,
  String? label,
  void Function()? onPressed,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: label == null
          ? const Duration(seconds: 3)
          : const Duration(seconds: 6),
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.secondryColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: AppColors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyles.regular16_120(context, color: AppColors.white),
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
