import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/features/app/presentation/controller/cubit/elec_rosary_cubit.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const double containerHight = 80;
    const double containerWidth = 250;
    const double spacing = 15;

    return SizedBox(
      height: containerHight + spacing + (containerWidth * 1 / 2),
      child: Stack(children: [
        Container(
            alignment: Alignment.center,
            width: containerWidth,
            height: containerHight,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(18)),
            ),
            child: BlocBuilder<ElecRosaryCubit, ElecRosaryState>(
                builder: (context, state) {
              return AnimatedSlide(
                  duration: AppDurations.lowDuration,
                  offset: state.offset,
                  child: AnimatedOpacity(
                    opacity: state.opacity,
                    duration: const Duration(seconds: 0),
                    child: Text(
                      context.elecRosaryController.counter.toString(),
                      style: TextStyles.semiBold32(context,
                          color: AppColors.white),
                    ),
                  ));
            })),
        Positioned(
          top: containerHight +
              spacing, //80 for container hight and 15 for spacing.
          right: 0.0,
          child: GestureDetector(
            onTap: () => context.elecRosaryController.resetCounter(),
            child: Align(
              alignment: Alignment.topLeft,
              child: const CircleAvatar(
                backgroundColor: AppColors.secondryColor,
                radius: 10,
              ),
            ),
          ),
        ),
        Positioned(
          top: containerHight +
              spacing, //80 for container hight and 15 for spacing.
          left: 0.0, right: 0.0,
          child: GestureDetector(
            onTap: () {
              context.elecRosaryController.increaseCounter();
            },
            child: CircleAvatar(
              radius: (containerWidth * 1 / 2) / 2, //half of counter container
              backgroundColor: AppColors.primaryColor,
            ),
          ),
        )
      ]),
    );
  }
}
