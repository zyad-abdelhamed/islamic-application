import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:segment_display/segment_display.dart';
import 'package:test_app/core/constants/font_familys.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/extentions/theme_extention.dart';
import 'package:test_app/features/app/presentation/controller/cubit/time_style_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_state.dart';

class DisplayTimeContainer extends StatelessWidget {
  final int index;
  final TimeNumberStyle currentTimeStyle;

  const DisplayTimeContainer({
    super.key,
    required this.index,
    required this.currentTimeStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      alignment: Alignment.center,
      foregroundDecoration: _foregroundDecoration,
      decoration: _decoration,
      child: BlocSelector<TimerCubit, TimerState, String>(
        selector: (state) {
          if (index == 0) return state.seconds.toString().padLeft(2, '0');
          if (index == 1) return state.minutes.toString().padLeft(2, '0');
          return state.hours.toString().padLeft(2, '0');
        },
        builder: (context, timeValue) {
          return _buildTimeByStyle(timeValue, context);
        },
      ),
    );
  }

  Widget _buildTimeByStyle(String value, BuildContext context) {
    switch (currentTimeStyle) {
      case TimeNumberStyle.fingerPaint:
        return Text(
          value,
          style: context.headlineLarge.copyWith(
            fontFamily: FontFamilys.fingerPaint,
            fontWeight: FontWeight.bold,
            color: AppColors.secondryColor,
          ),
        );

      case TimeNumberStyle.normal:
        return Text(
          value,
          style: context.headlineLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.secondryColor,
          ),
        );

      case TimeNumberStyle.sevenSegment:
        return SevenSegmentDisplay(
          value: value,
          size: 3,
          backgroundColor: Colors.transparent,
          segmentStyle: DefaultSegmentStyle(
            enabledColor: AppColors.secondryColor,
            disabledColor: AppColors.secondryColor.withValues(alpha: 0.15),
          ),
        );
    }
  }

  BoxDecoration get _foregroundDecoration =>
      BoxDecoration(color: Colors.black.withAlpha(5));

  BoxDecoration get _decoration => BoxDecoration(
        gradient: _gradient,
        borderRadius: _borderRadius[index],
      );

  LinearGradient get _gradient => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.secondryColorInActiveColor.withAlpha(70),
          AppColors.secondryColorInActiveColor.withAlpha(170),
          AppColors.secondryColorInActiveColor,
        ],
      );

  List<BorderRadiusGeometry> get _borderRadius {
    const radius = Radius.circular(10);
    return const [
      BorderRadius.only(topLeft: radius, bottomLeft: radius),
      BorderRadius.all(radius),
      BorderRadius.only(topRight: radius, bottomRight: radius),
    ];
  }
}
