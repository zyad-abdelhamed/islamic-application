import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/presentation/view/components/prayer_times_inner_container.dart';
import 'package:test_app/features/app/presentation/view/components/prayer_times_widget_background_image.dart';

class PrimaryPrayerTimesContainer extends StatelessWidget {
  const PrimaryPrayerTimesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        gradient: LinearGradient(
          colors: Theme.of(context).brightness == Brightness.dark
              ? [Color(0xFF2A7BAE), Color(0xFF3B8E75)]
              : [const Color(0xFF4CC8F4), const Color(0xFF6AD6B9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.6),
            blurRadius: 12,
            spreadRadius: 1,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: PrayerTimesWidgetBackgroundImage(),
          ),
          const PrayerTimesInnerContainer(),
        ],
      ),
    );
  }
}

class WavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final paint3 = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    // الموجة الأولى
    final path1 = Path()
      ..moveTo(0, size.height * 0.25)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.05,
          size.width * 0.75, size.height * 0.3)
      ..quadraticBezierTo(
          size.width * 0.95, size.height * 0.4, size.width, size.height * 0.2)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    // الموجة الثانية
    final path2 = Path()
      ..moveTo(0, size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.2, size.height * 0.3, size.width * 0.6,
          size.height * 0.55)
      ..quadraticBezierTo(
          size.width * 0.9, size.height * 0.65, size.width, size.height * 0.4)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    // الموجة الثالثة
    final path3 = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.5,
          size.width * 0.55, size.height * 0.72)
      ..quadraticBezierTo(
          size.width * 0.85, size.height * 0.8, size.width, size.height * 0.55)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);
    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
