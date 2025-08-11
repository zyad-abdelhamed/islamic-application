import 'dart:math';
import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final double progress;
  final double maxProgress;
  final Color lineColor;
  final double lineSize;
  final BuildContext context;

  final double? gapDegree;     // مقدار الفراغ بين الأجزاء (بالدرجات)
  final List<int>? gapAt;      // تظهر الفجوات عندما يكون progress مساويًا لأي عنصر فيها
  final int? segments;         // عدد الأجزاء (إذا لم يتم تمريره يُحسب تلقائيًا)

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
      ..strokeCap = StrokeCap.square;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * (progress / maxProgress);

   final shouldDrawWithGap = gapDegree != null &&
    gapAt != null &&
    gapAt!.any((value) => (progress - value).abs() < 0.1);

    final int usedSegments = segments ?? (maxProgress * 3).toInt().clamp(3, 100);

    if (shouldDrawWithGap) {
      final gapRadians = degToRad(gapDegree!);
      final segmentSweep = (sweepAngle / usedSegments) - gapRadians;

      for (int i = 0; i < usedSegments; i++) {
        final currentStart = startAngle + i * (segmentSweep + gapRadians);
        if (currentStart + segmentSweep > startAngle + sweepAngle) break;

        canvas.drawArc(rect, currentStart, segmentSweep, false, paint);
      }
    } else {
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.lineColor != lineColor ||
      oldDelegate.lineSize != lineSize;

  double degToRad(double deg) => deg * pi / 180;
}