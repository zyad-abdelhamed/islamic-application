import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class RemainingTimeWidget extends StatelessWidget {
  const RemainingTimeWidget({super.key});
  final double borderRadius = 10.0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'الوقت المتبقي : ',
          style: TextStyles.bold20(context),
        ),
        SizedBox(
          height: 50, //hight of Display Time Container
          width: 50 * 3, //width of 3 Display Time Container
          child: Stack(
            children: <Widget>[
              Row(
                children: <DisplayTimeContainer>[
                  DisplayTimeContainer(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(borderRadius),
                          bottomLeft: Radius.circular(borderRadius))),
                  DisplayTimeContainer(
                      borderRadius: BorderRadius.circular(borderRadius)),
                  DisplayTimeContainer(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(borderRadius),
                        bottomRight: Radius.circular(borderRadius)),
                  ),
                ],
              ),
              Center(
                child: FittedBox(
                  //to fit child in stack
                  child: Row(
                    children: List<SizedBox>.generate(
                        2,
                        (index) => SizedBox(
                            //fixed hight to Vertical Divider
                            height: 50,
                            width: 50,
                            child: VerticalDivider(
                                thickness: 3,
                                indent: 10,
                                endIndent: 10,
                                color: AppColors.white.withValues(alpha: .5)))),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class DisplayTimeContainer extends StatelessWidget {
  final BorderRadiusGeometry borderRadius;
  const DisplayTimeContainer({
    super.key,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.secondryColor, borderRadius: borderRadius),
      height: 50,
      width: 50,
      alignment: Alignment.center,
      child: Text('03',
          style: TextStyles.semiBold32(context, color: AppColors.purple)),
    );
  }
}
