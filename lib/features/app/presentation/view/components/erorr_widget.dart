import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class ErrorWidgetIslamic extends StatelessWidget {
  const ErrorWidgetIslamic({
    super.key,
    required this.message,
    this.onPressed,
    this.buttonWidget,
  });

  final String message;
  final void Function()? onPressed;
  final Widget? buttonWidget;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 500, // يفضل يمنع الكارد من التمدد أوي في الشاشات الكبيرة
        ),
        child: Card(
          color: Colors.black.withAlpha(190),
          margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 16.0,
            ),
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

                // Scroll للنص الطويل
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight:
                        screenHeight * 0.3, // أقصى ارتفاع للنص 30% من الشاشة
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      message,
                      style: TextStyles.regular16_120(
                        context,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                ),

                if (buttonWidget != null)
                  TextButton(
                    onPressed: onPressed,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                    ),
                    child: buttonWidget!,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
