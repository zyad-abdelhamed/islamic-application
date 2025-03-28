import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app/presentation/controller/cubit/alert_dialog_cubit.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class DrawCircleBlocBuilder extends StatelessWidget {
  const DrawCircleBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
            child: CustomPaint(
          size: Size(context.width * .60, context.width * .60),
          painter:
              CirclePainter(100, context, AppColors.inActiveThirdColor),
        )),
        BlocBuilder<AlertDialogCubit, AlertDialogState>(
          builder: (context, state) {
            return Stack(
              children: [
                Center(
                    child: CustomPaint(
                  size: Size(context.width * .60, context.width * .60),
                  painter: CirclePainter(
                      state.progress, context, AppColors.thirdColor),
                )),
                Center(
                  child: TextButton(
                      style: ButtonStyle(
                          overlayColor: WidgetStatePropertyAll(
                              Colors.transparent)),
                      onPressed: () {},
                      child: Text(
                        state.getText,
                        style: TextStyles.semiBold32(context,
                            color: AppColors.white),
                      )),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}

class CirclePainter extends CustomPainter {
  final int progress;
  final int lastCount = 100;
  final Color lineColor;
  final BuildContext context;

  CirclePainter(this.progress, this.context, this.lineColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawArc(
        rect,
        300, //todo
        progress /
            lastCount *
            2 *
            3.14, // 2 * 3.14 = circle so when progress = 100 the circle is complete.
        false,
        paint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) =>
      oldDelegate.progress != progress;

  @override
  bool shouldRebuildSemantics(CirclePainter oldDelegate) => false;
}
