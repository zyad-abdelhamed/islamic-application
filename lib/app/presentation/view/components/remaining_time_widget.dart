import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:segment_display/segment_display.dart';
import 'package:test_app/app/presentation/controller/cubit/prayer_times_cubit.dart';
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
                          color: AppColors.white.withOpacity(0.5),
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
          print('إعادة بناء النص الخاص بـ index: $index');
          return SevenSegmentDisplay(
            size: 3,
            segmentStyle: DefaultSegmentStyle(enabledColor: AppColors.purple,disabledColor: Colors.transparent),
            backgroundColor: Colors.transparent,
            value:  timeValue,
            // style: TextStyles.semiBold32(context, color: AppColors.purple),
          );
        },
      ),
    );
  }
}

List<BorderRadiusGeometry> _getBorderRadiuses() {
  return <BorderRadiusGeometry>[
    const BorderRadius.only(
        topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
    BorderRadius.circular(10),
    const BorderRadius.only(
        topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
  ];
}
