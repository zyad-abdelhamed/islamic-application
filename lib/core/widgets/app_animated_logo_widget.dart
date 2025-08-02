
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AppAnimatedLogoWidget extends StatelessWidget {
  const AppAnimatedLogoWidget({
    super.key, required this.isRepeating,
  });
 
 final bool isRepeating;

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        FadeAnimatedText(
          'نور',
          textStyle: TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 30.0,
                color: Colors.yellowAccent,
                offset: Offset(0, 0),
              ),
            ],
          ),
          duration: const Duration(seconds: 2),
        ),
      ],
      isRepeatingAnimation: isRepeating,
        repeatForever: isRepeating,
        pause: const Duration(milliseconds: 500),
    );
  }
}