import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/view/components/circle_painter.dart';

class CommonCircleLayout extends StatelessWidget {
  const CommonCircleLayout({
    super.key,
    required this.customPaintSize,
    required this.maxProgress,
    required this.dashDegree,
    required this.gapDegree,
    required this.progressNotifier,
    required this.textNotifier,
    required this.gapAt,
    required this.onPressed,
    required this.segments,
  });

  final double customPaintSize;
  final double maxProgress;
  final double dashDegree; // طول الـ dash بالدرجات
  final double gapDegree; // طول الـ gap بالدرجات
  final ValueNotifier<int> progressNotifier;
  final ValueNotifier<String> textNotifier;
  final List<int> gapAt; // list of pattern indices to skip (0-based)>
  final VoidCallback onPressed;
  final int segments;

  @override
  Widget build(BuildContext context) {
    final bool isDark = ThemeCubit.controller(context).state;

    return SizedBox(
      width: customPaintSize,
      height: customPaintSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // الخلفية (track) كاملة
          CustomPaint(
            size: Size(customPaintSize, customPaintSize),
            painter: CirclePainter(
              context: context,
              segments: segments,
              gapAt: gapAt,
              gapDegree: gapDegree,
              progress: maxProgress, // full background track
              maxProgress: maxProgress,
              lineSize: 20.0,
              lineColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
            ),
          ),

          // القوس المتحرك بحسب الـ notifier
          ListenableBuilder(
            listenable: progressNotifier,
            builder: (_, __) {
              return CustomPaint(
                size: Size(customPaintSize, customPaintSize),
                painter: CirclePainter(
                  context: context,
                  segments: segments,
                  gapAt: gapAt,
                  gapDegree: gapDegree,
                  progress: progressNotifier.value.toDouble(),
                  maxProgress: maxProgress,
                  lineSize: 20.0,
                  lineColor: Theme.of(context).primaryColor,
                ),
              );
            },
          ),
          // زر في المنتصف
          Positioned.fill(
            child: GestureDetector(
              onTap: onPressed,
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: ListenableBuilder(
                    listenable: textNotifier,
                    builder: (_, __) => Text(
                      textNotifier.value,
                      maxLines: 1,
                      style: TextStyles.semiBold32(
                        context,
                        color: isDark
                            ? AppColors.darkModeTextColor
                            : AppColors.lightModePrimaryColor,
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
