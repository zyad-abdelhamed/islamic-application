import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widget_depending_on_os.dart';
import 'package:test_app/features/app/presentation/controller/cubit/home_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_to_android_and_ios.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_to_desktop.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/splash_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TimerCubit()),
          BlocProvider(create: (context) => HomeCubit(sl(), sl())..getPrayersTimes(context)..showTodatHadith(context)),
        ],
        child: Stack(
          children: [
            adaptiveWidgetDependingOnOs(
            defaultWidget: HomePageToDesktop(),
            androidWidget: HomePageToAndroidAndIos(),
            iosWidget: HomePageToAndroidAndIos()),
            // ===splash screen===
            SplashScreen()
          ],
        ));
  }
}
