import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class ErrorWidgetIslamic extends StatelessWidget {
  final String message;

  const ErrorWidgetIslamic({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: AppColors.secondryColor.withValues(alpha: 0.1),
        margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 60,
                color: AppColors.errorColor,
              ),
              const SizedBox(height: 16),
              Text(
                'عذرًا، حدث خطأ',
                style: TextStyles.semiBold18(context, AppColors.errorColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                message,
                style: TextStyles.regular16_120(context, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
