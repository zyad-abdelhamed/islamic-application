import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/presentation/view/pages/home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 200,
        duration: 2,
        splash: Image.asset('assets/images/mosque (1).png',),
        nextScreen:const HomePage(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: AppColors.primaryColor);
  }
}
