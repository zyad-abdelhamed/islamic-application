import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/presentation/controller/cubit/alert_dialog_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/draw_circle_line_bloc_builder.dart';
import 'package:test_app/core/constants/view_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class RosaryRingWidget extends StatelessWidget {
  const RosaryRingWidget({super.key});

  final double maxProgress = 3.0;

  @override
  Widget build(BuildContext context) {
    final double customPaintSize = context.width * .45;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DrawCircleLineBlocBuilder(
            customPaintSize: customPaintSize,
            maxProgress: maxProgress,
            functionality: DrawCircleLineBlocBuilderFunctionality.ringRosary),
        Column(
          spacing: 35.0,
          children: List<BlocBuilder>.generate(
            ViewConstants.ringRosaryTexts.length,
            (index) => _customContainer(index: index),
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
          duration: ViewConstants.mediumDuration,
          alignment: Alignment.center,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(color: AppColors.secondryColor, width: 3),
              color: state.getContainerColor(index)),
          child: FittedBox(
            child: Text(
              ViewConstants.ringRosaryTexts[index],
              style: TextStyles.semiBold18(context, AppColors.white)
                  .copyWith(fontSize: 23),
            ),
          ),
        );
      },
    );
  }
}
