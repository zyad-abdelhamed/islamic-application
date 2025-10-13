import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:segment_display/segment_display.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_state.dart';

class RemainingTimeWidget extends StatelessWidget {
  const RemainingTimeWidget({super.key});
  final double borderRadius = 10.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Text(
          AppStrings.translate("remainingTime"),
          style: TextStyles.bold20(context),
        ),
        SizedBox(
          height: 60,
          width: 60 * 3,
          child: Stack(
            children: <Widget>[
              Row(
                  children: List<DisplayTimeContainer>.generate(
                3,
                (index) {
                  return DisplayTimeContainer(index: index);
                },
              )),
              Center(
                child: FittedBox(
                  child: Row(
                    children: List.generate(
                      2,
                      (index) => SizedBox(
                        height: 60,
                        width: 60,
                        child: VerticalDivider(
                          thickness: 3,
                          indent: 10,
                          endIndent: 10,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
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
  final int index;
  const DisplayTimeContainer({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondryColor,
        borderRadius: _getBorderRadiuses()[index],
      ),
      height: 60,
      width: 60,
      alignment: Alignment.center,
      child: BlocSelector<TimerCubit, TimerState, String>(
        selector: (state) {
          if (index == 0) {
            return state.seconds.toString().padLeft(2, '0'); // ثواني
          }
          if (index == 1) {
            return state.minutes.toString().padLeft(2, '0'); // دقائق
          }
          return state.hours.toString().padLeft(2, '0'); // ساعات
        },
        builder: (context, timeValue) {
          return SevenSegmentDisplay(
            size: 3,
            segmentStyle: DefaultSegmentStyle(
                enabledColor: AppColors.purple,
                disabledColor: AppColors.purple.withValues(alpha: .1)),
            backgroundColor: Colors.transparent,
            value: timeValue,
          );
        },
      ),
    );
  }
}

List<BorderRadiusGeometry> _getBorderRadiuses() {
  const double borderRadius = 10.0;
  return <BorderRadiusGeometry>[
    const BorderRadius.only(
        topLeft: Radius.circular(borderRadius),
        bottomLeft: Radius.circular(borderRadius)),
    BorderRadius.circular(borderRadius),
    const BorderRadius.only(
        topRight: Radius.circular(borderRadius),
        bottomRight: Radius.circular(borderRadius)),
  ];
}
