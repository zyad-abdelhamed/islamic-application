import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class ErorrWidget extends StatelessWidget {
  final String message;
  const ErorrWidget({
    super.key, required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
      child: Text(
        "حدث خطأ: $message",
        textAlign: TextAlign.center,
        style: TextStyles.semiBold18(
            context, AppColors.errorColor),
      ),
    ));
  }
}
