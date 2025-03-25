import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/timer/cubit/timer_cubit.dart';
import 'package:test_app/timer/cubit/timer_state.dart';

class RemainingTimeWidget extends StatelessWidget {
  const RemainingTimeWidget({super.key});
  final double borderRadius = 10.0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'الوقت المتبقي : ',
          style: TextStyles.bold20(context)
              .copyWith(color: AppColors.secondryColor, fontSize: 27),
        ),
        SizedBox(
          height: 50, //hight of Display Time Container
          width: 50 * 3, //width of 3 Display Time Container
          child: Stack(
            children: <Widget>[
              BlocBuilder<TimerCubit, TimerState>(
                builder: (context, state) {
                  return Row(
                    children: <DisplayTimeContainer>[
                      DisplayTimeContainer(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(borderRadius),
                            bottomLeft: Radius.circular(borderRadius)),
                        text: state.seconds.toString().padLeft(2, '0'),
                      ),
                      DisplayTimeContainer(
                        borderRadius: BorderRadius.circular(borderRadius),
                        text: state.minutes.toString().padLeft(2, '0'),
                      ),
                      DisplayTimeContainer(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(borderRadius),
                            bottomRight: Radius.circular(borderRadius)),
                        text: state.hours.toString().padLeft(2, '0'),
                      ),
                    ],
                  );
                },
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
  final String text;
  const DisplayTimeContainer({
    super.key,
    required this.borderRadius,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.secondryColor, borderRadius: borderRadius),
      height: 50,
      width: 50,
      alignment: Alignment.center,
      child: Text(text,
          style: TextStyles.semiBold32(context, color: AppColors.purple)),
    );
  }
}
