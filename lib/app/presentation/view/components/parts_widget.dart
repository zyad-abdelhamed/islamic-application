import 'package:flutter/material.dart';
import 'package:test_app/core/constants/view_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class PartsWidget extends StatelessWidget {
  const PartsWidget({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    const double borderRadius = 60;

    return AnimatedContainer(
      transformAlignment: Alignment.bottomRight,
      duration: ViewConstants.mediumDuration,
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              bottomLeft: Radius.circular(borderRadius))),
      height: height,
      width: width,
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<AnimatedContainer>.generate(
              30,
              (index) => AnimatedContainer(
                  duration: ViewConstants.lowDuration,
                  color:
                      index == 5 ? AppColors.secondryColor : Colors.transparent,
                  child: Text(
                    'الجزء الأول',
                    style: TextStyles.bold20(context)
                        .copyWith(color: AppColors.white, fontSize: 23),
                  ))),
        ),
      ),
    );
  }
}
