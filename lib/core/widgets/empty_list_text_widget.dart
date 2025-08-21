import 'package:flutter/cupertino.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
class EmptyListTextWidget extends StatelessWidget {
  final String text;

  const EmptyListTextWidget({
    super.key,
    this.text = "القائمة فارغة",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.secondryColor.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.circle_grid_3x3_fill,
              color: AppColors.secondryColor,
              size: 64,
            ),
          ),
          // النص
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyles.bold20(context).copyWith(
              color: AppColors.secondryColor,
            ),
          ),
        ],
      ),
    );
  }
}
