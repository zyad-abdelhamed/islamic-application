import 'dart:ui';

import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final double progress;
  final double maxProgress;
  final Color lineColor;
  final double lineSize;
  final BuildContext context;

  CirclePainter(
      {required this.progress,
      required this.lineSize,
      required this.context,
      required this.lineColor,
      required this.maxProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineSize;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawArc(
        rect,
        300, //todo
        progress /
            maxProgress *
            2 *
            3.14, // 2 * 3.14 = circle so when progress = max progress the circle is complete.
        false,
        paint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) =>
      oldDelegate.progress != progress;

  @override
  bool shouldRebuildSemantics(CirclePainter oldDelegate) => false;
}