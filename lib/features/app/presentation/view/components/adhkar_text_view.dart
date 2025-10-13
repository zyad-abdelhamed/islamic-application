import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class AdhkarTextView extends StatelessWidget {
  const AdhkarTextView({
    super.key,
    required this.content,
    required this.desc,
    required this.fontSizeNotfier,
  });

  final String content;
  final String? desc;
  final ValueNotifier<double> fontSizeNotfier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: fontSizeNotfier,
      builder: (_, double val, ___) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content,
            style: TextStyles.bold20(context)
                .copyWith(fontFamily: 'DataFontFamily', fontSize: val),
          ),
          if (desc != null && desc!.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                desc!,
                style: TextStyles.regular16_120(context,
                        color: AppColors.secondryColor)
                    .copyWith(fontFamily: 'Amiri', fontSize: val - 4),
              ),
            ),
        ],
      ),
    );
  }
}
