import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/widgets/app_loading_widget.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_prayer_times_controller.dart';
import 'package:test_app/features/splach_screen/view/components/app_animated_logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final ValueNotifier<bool> showLoading;

  void _goToHomePage() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesConstants.homePageRouteName,
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    showLoading = ValueNotifier<bool>(false);

    /// بعد ما يخلص عرض اللوجو (نفس مدة الأنيميشن)
    Future.delayed(AppDurations.longDuration, () {
      if (mounted) {
        showLoading.value = true;

        // بعدها تبدأ تحميل البيانات
        sl<GetPrayersTimesController>()
            .getPrayersTimes(onTerminated: _goToHomePage);
      }
    });
  }

  @override
  void dispose() {
    showLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          const Center(
            child: AppAnimatedLogoWidget(),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<bool>(
              valueListenable: showLoading,
              builder: (context, bool value, Widget? child) {
                return AnimatedOpacity(
                  duration: AppDurations.lowDuration,
                  opacity: value ? 1 : 0,
                  child: child!,
                );
              },
              child: const AppLoadingWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
