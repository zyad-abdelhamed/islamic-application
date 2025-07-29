import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/controller/cubit/alert_dialog_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/draw_circle_line_bloc_builder.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class RosaryRingWidget extends StatelessWidget {
  const RosaryRingWidget({super.key});

  final double maxProgress = 3.0;

  @override
  Widget build(BuildContext context) {
    const double customPaintSize = 150;
    const double spacing = 5.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 35,
      children: [
        Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List.generate(
            AppStrings.adhkarList.length,
            (index) => _customContainer(context, index: index),
          ),
        ),
        DrawCircleLineBlocBuilder(
            customPaintSize: customPaintSize,
            maxProgress: maxProgress,
            functionality: DrawCircleLineBlocBuilderFunctionality.ringRosary),
      ],
    );
  }

  _customContainer(BuildContext context, {required int index}) {
    return BlocBuilder<AlertDialogCubit, AlertDialogState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: AppDurations.mediumDuration,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(color: AppColors.primaryColor(context), width: 3),
              color: state.getContainerColor(context, index)),
          child: Text(
            AppStrings.adhkarList[index],
            style: TextStyles.semiBold18(
                context,
                ThemeCubit.controller(context).state
                    ? AppColors.white
                    : AppColors.black),
          ),
        );
      },
    );
  }
}
