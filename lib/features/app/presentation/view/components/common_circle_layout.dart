import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/view/components/circle_painter.dart';

class CommonCircleLayout extends StatelessWidget {
  const CommonCircleLayout({
    super.key,
    required this.customPaintSize,
    this.lineSize = 20.0,
    required this.maxProgress,
    this.dashDegree,
    this.gapDegree,
    required this.progressNotifier,
    this.textBuilder,
    this.gapAt,
    this.onPressed,
    this.segments,
  });

  final double customPaintSize;
  final double? lineSize;
  final double maxProgress;
  final double? dashDegree; // طول الـ dash بالدرجات
  final double? gapDegree; // طول الـ gap بالدرجات
  final ValueNotifier<double> progressNotifier;
  final String Function()? textBuilder;
  final List<int>? gapAt; // list of pattern indices to skip (0-based)
  final VoidCallback? onPressed;
  final int? segments;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: customPaintSize,
      height: customPaintSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // الخلفية (track) كاملة - ثابتة مش محتاجة RepaintBoundary
          CustomPaint(
            size: Size(customPaintSize, customPaintSize),
            painter: CirclePainter(
              context: context,
              segments: segments,
              gapAt: gapAt,
              gapDegree: gapDegree,
              progress: maxProgress, // full background track
              maxProgress: maxProgress,
              lineSize: lineSize!,
              lineColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
            ),
          ),

          // القوس المتحرك بحسب الـ notifier
          ListenableBuilder(
            listenable: progressNotifier,
            builder: (_, __) {
              return RepaintBoundary(
                // RepaintBoundary: عشان نعزل الدايرة في Layer منفصلة وتترسم بس لما يتغير progress،
                // وده يقلل من الحمل على الأداء.
                child: CustomPaint(
                  size: Size(customPaintSize, customPaintSize),
                  painter: CirclePainter(
                    context: context,
                    segments: segments,
                    gapAt: gapAt,
                    gapDegree: gapDegree,
                    progress: progressNotifier.value.toDouble(),
                    maxProgress: maxProgress,
                    lineSize: lineSize!,
                    lineColor: Theme.of(context).primaryColor,
                  ),
                ),
              );
            },
          ),

          // زر في المنتصف + النص
          Visibility(
            visible: textBuilder != null,
            child: Positioned.fill(
              child: GestureDetector(
                onTap: onPressed,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                  ),
                  alignment: Alignment.center,
                  child: ListenableBuilder(
                    listenable: progressNotifier,
                    builder: (_, __) => Text(
                      textBuilder!(),
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 3,
                      style: TextStyles.bold20(context).copyWith(
                        color: isDark
                            ? AppColors.darkModeTextColor
                            : AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
