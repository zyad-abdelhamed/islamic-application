import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_durations.dart';
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
    final double customPaintSize = 150;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DrawCircleLineBlocBuilder(
            customPaintSize: customPaintSize,
            maxProgress: maxProgress,
            functionality: DrawCircleLineBlocBuilderFunctionality.ringRosary),
        SingleChildScrollView(
          child: Column(
            spacing: 35.0,
            children: List<BlocBuilder>.generate(
              AppStrings.adhkarList.length,
              (index) => _customContainer(index: index),
            ),
          ),
        )
      ],
    );
  }

  BlocBuilder _customContainer({required int index}) {
    return BlocBuilder<AlertDialogCubit, AlertDialogState>(
      buildWhen: (previous, current) =>
          previous.getContainerColor(index) != current.getContainerColor(index),
      builder: (context, state) {
        return AnimatedContainer(
          duration: AppDurations.mediumDuration,
          alignment: Alignment.center,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(color: AppColors.secondryColor, width: 3),
              color: state.getContainerColor(index)),
          child: FittedBox(
            child: Text(
              AppStrings.adhkarList[index],
              style: TextStyles.semiBold18(context, AppColors.white)
                  .copyWith(fontSize: 23),
            ),
          ),
        );
      },
    );
  }
}
