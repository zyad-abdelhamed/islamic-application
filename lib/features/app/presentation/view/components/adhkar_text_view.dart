import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/extentions/theme_extention.dart';

class AdhkarTextView extends StatelessWidget {
  const AdhkarTextView({
    super.key,
    required this.content,
    required this.desc,
    required this.fontSizeNotfier,
    required this.spacing,
  });

  final String content;
  final String? desc;
  final ValueNotifier<double> fontSizeNotfier;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: fontSizeNotfier,
      builder: (_, double val, ___) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content,
            style: context.headlineLarge.copyWith(
              fontSize: val,
              fontFamily: 'dataFontFamily',
              color: AppColors.primaryColor,
            ),
          ),
          if (desc != null && desc!.trim().isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: spacing),
              child: Text(
                desc!,
                style: context.labelLarge.copyWith(
                  fontSize: val - 4,
                  fontFamily: 'Amiri',
                  color: AppColors.primaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
