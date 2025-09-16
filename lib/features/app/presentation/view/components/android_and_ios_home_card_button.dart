import 'package:flutter/material.dart';
import 'package:test_app/core/constants/routes_constants.dart';

class AndroidAndIosHomeCardButton extends StatelessWidget {
  const AndroidAndIosHomeCardButton({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
    required this.gradientColors,
    required this.height,
    required this.scale,
    required this.page,
  });

  final String image;
  final String title;
  final String? desc;
  final List<Color> gradientColors;
  final double height, scale;
  final dynamic page;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: GestureDetector(
        onTap: () => onTap(context),
        child: Container(
          height: height,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.08)
                    : Colors.grey.withOpacity(0.6),
                blurRadius: 12,
                spreadRadius: 1,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            children: [
              // الموجة
              Positioned.fill(
                child: RepaintBoundary(
                  child: CustomPaint(
                    painter: WavePainter(),
                  ),
                ),
              ),
              // محتوى الزرار
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Image.asset(
                      image,
                      fit: BoxFit.fill,
                      width: 200 - 120,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  if (desc != null)
                    Text(
                      desc!,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  const SizedBox(height: 4),
                  const Text(
                    "انتقال >",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTap(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WillPopScope(
            onWillPop: () async {
              Navigator.pushReplacementNamed(
                context,
                RoutesConstants.homePageRouteName,
              );

              return false;
            },
            child: page,
          ),
        ));
  }
}

/// 🎨 يرسم الموجة بلون أبيض شفاف
class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1) // لون الموجة
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.5,
        size.width * 0.5, size.height * 0.6);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.7, size.width, size.height * 0.6);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
