import 'dart:math';
import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final double progress;
  final double maxProgress;
  final Color lineColor;
  final double lineSize;
  final BuildContext context;

  final double? gapDegree; // ممكن نسيبه لو حابب تتحكم في طول الفجوة
  final List<int>? gapAt;  // القيم اللي عندها بيقف الخط ويتعمل فراغ
  final int? segments;     // عدد القطع (dashes)

  CirclePainter({
    required this.progress,
    required this.maxProgress,
    required this.lineSize,
    required this.context,
    required this.lineColor,
    this.gapDegree,
    this.gapAt,
    this.segments,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineSize
      ..strokeCap = StrokeCap.butt;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final startAngle = -pi / 2;

    final double unitAngle = (2 * pi) / maxProgress;
    double currentProgress = 0;

    while (currentProgress < progress) {
      // إذا القيمة الحالية في gapAt → سيب فجوة
      if (gapAt != null && gapAt!.contains(currentProgress.toInt())) {
        currentProgress += 1; // نعدي خطوة ونسيب فراغ
        continue;
      }

      // نرسم segment صغير
      final dashLength = 1.0; // طول الـ dash بوحدة progress
      final sweep = unitAngle * dashLength;

      // نتأكد ألا نتخطى progress المطلوب
      if (currentProgress + dashLength > progress) {
        final remainingSweep = unitAngle * (progress - currentProgress);
        canvas.drawArc(
          rect,
          startAngle + (currentProgress * unitAngle),
          remainingSweep,
          false,
          paint,
        );
        break;
      }

      canvas.drawArc(
        rect,
        startAngle + (currentProgress * unitAngle),
        sweep,
        false,
        paint,
      );

      // نتحرك للقطعة التالية
      currentProgress += dashLength;
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.lineColor != lineColor ||
      oldDelegate.lineSize != lineSize;

  double degToRad(double deg) => deg * pi / 180;
}
