import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';

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
    final IconData icon;

    switch (type) {
      case AppSnackBarType.success:
        backgroundColor = AppColors.successColor;
        icon = Icons.check_circle;
        break;

      case AppSnackBarType.error:
        backgroundColor = AppColors.errorColor;
        icon = Icons.warning_amber_rounded;
        break;

      case AppSnackBarType.info:
        backgroundColor = AppColors.secondryColor;
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
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: "DataFontFamily",
                fontSize: 16,
              ),
            ),
          ),
          if (label != null)
            GestureDetector(
              onTap: () {
                // ينفذ onPressed لو موجود
                onPressed?.call();
                // وبعدها يختفي السناك بار فورا
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: Text(
                label!,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontFamily: "Cairo"),
              ),
            ),
        ],
      ),
    );
  }

  void show(BuildContext context) {
    // الشرط ده بيتأكد إن الـ widget اللي بنادي منه لسه mounted
    if (!context.mounted) return;

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
