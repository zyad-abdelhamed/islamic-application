import 'dart:math';
import 'package:flutter/material.dart';

class QiblaArrow extends StatelessWidget {
  final double angle;
  final double size;
  const QiblaArrow({required this.angle, this.size = 220, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // الخلفية الدائرية
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                radius: 0.9,
                colors: [
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[900]!
                      : Colors.white,
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.grey[300]!,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  offset: Offset(0, 4),
                  color: Colors.black26,
                )
              ],
            ),
          ),

          for (int i = 0; i < 12; i++)
            Transform.rotate(
              angle: (i * 30) * pi / 180,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 2,
                  height: size * 0.06,
                  color: Colors.black12,
                ),
              ),
            ),

          // السهم نفسه
          Transform.rotate(
            angle: angle,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.navigation, // سهم
                  size: size * 0.45,
                ),
                SizedBox(height: 6),
                Text('القبلة', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
