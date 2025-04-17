import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/presentation/controller/cubit/alert_dialog_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/circle_painter.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class DrawCircleLineBlocBuilder extends StatelessWidget {
  const DrawCircleLineBlocBuilder({
    super.key,
    required this.customPaintSize,
    required this.maxProgress, required this.functionality,
  });

  final double customPaintSize;
  final double maxProgress;
  final DrawCircleLineBlocBuilderFunctionality functionality;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size(customPaintSize, customPaintSize),
          painter: CirclePainter(
              progress: maxProgress,
              lineSize: 10.0,
              context: context,
              lineColor: AppColors.inActiveThirdColor,
              maxProgress: maxProgress),
        ),
        BlocBuilder<AlertDialogCubit, AlertDialogState>(
          buildWhen: (previous, current) =>
              previous.progress != current.progress,
          builder: (context, state) {
            return CustomPaint(
              size: Size(customPaintSize, customPaintSize),
              painter: CirclePainter(
                  lineSize: 10.0,
                  progress: state.progress,
                  context: context,
                  lineColor: AppColors.thirdColor,
                  maxProgress: maxProgress),
            );
          },
        ),
        Positioned(
          top: 10.0,
          right: 10.0,
          bottom: 10.0,
          left: 10.0,
          child: Container(
            height: double.infinity,width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(300),
              color: AppColors.inActivePrimaryColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  spreadRadius: 3,
                  color: AppColors.white.withValues(alpha: .3)
                )
              ]
            ),
            child: TextButton(
                style: ButtonStyle(
                    overlayColor: WidgetStatePropertyAll(Colors.transparent)),
                onPressed: () {
                  switch(functionality){

                    case DrawCircleLineBlocBuilderFunctionality.ringRosary:
                                        context.alertDialogController.drawRosaryRing(context);

                    case DrawCircleLineBlocBuilderFunctionality.rosariesAfterPrayer:
                      context.alertDialogController.drawCircle(context);
                  }
                },
                child: BlocBuilder<AlertDialogCubit, AlertDialogState>(
                  buildWhen: (previous, current) =>
                      switch(functionality){
                        DrawCircleLineBlocBuilderFunctionality.ringRosary => previous.getRingText != current.getRingText,
                        DrawCircleLineBlocBuilderFunctionality.rosariesAfterPrayer => previous.getText != current.getText,
                      },
                  builder: (context, state) {
                    return FittedBox(
                      child: Text(
                        switch(functionality){
                        DrawCircleLineBlocBuilderFunctionality.ringRosary => state.getRingText,
                        DrawCircleLineBlocBuilderFunctionality.rosariesAfterPrayer => state.getText,
                      },
                        maxLines: 1,
                        style: TextStyles.semiBold32(context,
                            color: AppColors.primaryColor),
                      ),
                    );
                  },
                )),
          ),
        ),
      ],
    );
  }
}

enum DrawCircleLineBlocBuilderFunctionality {
  ringRosary,rosariesAfterPrayer
}