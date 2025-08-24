import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widget_depending_on_os.dart';
import 'package:test_app/features/app/presentation/controller/controllers/home_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayer_times_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_to_android_and_ios.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_to_desktop.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomePageController _homePageController;
  late final NextPrayerController nextPrayerController;
  @override
  void initState() {
    super.initState();
    _homePageController = HomePageController();
    nextPrayerController = NextPrayerController();
    _homePageController.initState(context,
        nextPrayerController: nextPrayerController);
  }

  @override
  Widget build(BuildContext context) {
    return adaptiveWidgetDependingOnOs(
      defaultWidget:
          HomePageToDesktop(nextPrayerController: nextPrayerController),
      androidWidget:
          HomePageToAndroidAndIos(nextPrayerController: nextPrayerController),
      iosWidget:
          HomePageToAndroidAndIos(nextPrayerController: nextPrayerController),
    );
  }
}
