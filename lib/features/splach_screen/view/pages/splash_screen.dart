import 'package:flutter/material.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_prayer_times_controller.dart';


class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final ValueNotifier<double> opacityNotifier = ValueNotifier<double>(0.0);

  void start(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 300), () {
      opacityNotifier.value = 1.0;
    });
    sl<GetPrayersTimesController>().getPrayersTimes(context);
  }

  @override
  Widget build(BuildContext context) {
    start(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: ValueListenableBuilder<double>(
          valueListenable: opacityNotifier,
          builder: (context, opacity, _) {
            return AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              child: Image.asset(
                'assets/images/mosque (1).png',
                height: context.height * 0.5,
                width: context.width * 0.5,
              ),
            );
          },
        ),
      ),
    );
  }
}
