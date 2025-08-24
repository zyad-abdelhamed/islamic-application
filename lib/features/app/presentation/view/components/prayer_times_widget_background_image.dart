import 'package:flutter/material.dart';
import 'package:test_app/core/constants/constants_values.dart';

class PrayerTimesWidgetBackgroundImage extends StatelessWidget {
  const PrayerTimesWidgetBackgroundImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withAlpha(127),
            Colors.transparent,
          ],
        ).createShader(bounds),
        blendMode: BlendMode.dstIn,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft:
                Radius.circular(ConstantsValues.prayerTimesWidgetBorderRadius),
            bottomRight:
                Radius.circular(ConstantsValues.prayerTimesWidgetBorderRadius),
          ),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(3.14159), // 180 درجة على محور Y
            child: Image.asset(
              "assets/images/night_sky.jpg",
              height: 80,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
