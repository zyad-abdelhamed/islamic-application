import 'package:flutter/material.dart';
import 'package:test_app/core/constants/view_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class PartsWidget extends StatelessWidget {
  const PartsWidget({
    super.key,
  });

  final double _borderRadius = 60;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(_borderRadius),
              bottomLeft: Radius.circular(_borderRadius))),
      height: context.height * .70,
      width: 160,
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
