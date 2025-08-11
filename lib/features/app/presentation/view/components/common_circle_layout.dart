import 'package:flutter/material.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/view/components/circle_painter.dart';

class CommonCircleLayout extends StatelessWidget {
  const CommonCircleLayout({
    super.key,
    required this.customPaintSize,
    required this.maxProgress,
    required this.gapAt,
    required this.gapDegree,
    required this.notifier,
    required this.onPressed,
    required this.textBuilder,
    required this.progressReader,
  });

  final double customPaintSize;
  final double maxProgress;
  final List<int> gapAt;
  final double gapDegree;
  final ValueNotifier<void> notifier;
  final VoidCallback onPressed;
  final String Function() textBuilder;
  final double Function() progressReader;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size(customPaintSize, customPaintSize),
          painter: CirclePainter(
            gapDegree: gapDegree,
            gapAt: gapAt,
            progress: maxProgress,
            lineSize: 20.0,
            context: context,
            lineColor: Colors.grey.shade300,
            maxProgress: maxProgress,
          ),
        ),
        ValueListenableBuilder<void>(
          valueListenable: notifier,
          builder: (context, _, __) {
            return CustomPaint(
              size: Size(customPaintSize, customPaintSize),
              painter: CirclePainter(
                gapDegree: gapDegree,
                gapAt: gapAt,
                lineSize: 20.0,
                progress: progressReader(),
                context: context,
                lineColor: Theme.of(context).primaryColor,
                maxProgress: maxProgress,
              ),
            );
          },
        ),
        Positioned.fill(
          child: TextButton(
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
            ),
            onPressed: onPressed,
            child: ValueListenableBuilder<void>(
              valueListenable: notifier,
              builder: (context, _, __) {
                return FittedBox(
                  child: Text(
                    textBuilder(),
                    maxLines: 1,
                    style: TextStyles.semiBold32(
                      context,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
