import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

/// Enum لتحديد نوع الـ SnackBar
enum AppSnackBarType {
  success,
  error,
  info,
}

class AppSnackBar extends StatelessWidget {
  final String message;
  final String? label;
  final void Function()? onPressed;
  final AppSnackBarType type;

  const AppSnackBar({
    super.key,
    required this.message,
    this.label,
    this.onPressed,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor;
    final Color textColor;
    final IconData icon;

    switch (type) {
      case AppSnackBarType.success:
        backgroundColor = AppColors.successColor;
        textColor = AppColors.white;
        icon = Icons.check_circle;
        break;

      case AppSnackBarType.error:
        backgroundColor = AppColors.inActiveErrorColor;
        textColor = AppColors.errorColor;
        icon = Icons.warning_amber_rounded;
        break;

      case AppSnackBarType.info:
        backgroundColor = AppColors.secondryColor;
        textColor = AppColors.white;
        icon = Icons.info_outline;
        break;  
    }

    return Container(
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
          Icon(icon, color: textColor),
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
                label!,
                style: TextStyles.semiBold16(
                  context: context,
                  color: AppColors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// ميثود جاهزة لعرض الـ SnackBar
  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: label == null
            ? const Duration(seconds: 4)
            : const Duration(seconds: 8),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        content: this, // هنا بيرندر الـ widget نفسه
      ),
    );
  }
}
