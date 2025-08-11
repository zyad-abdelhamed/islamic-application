import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/app/presentation/controller/cubit/hadith_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayer_times_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayers_sound_settings_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_cubit.dart';
import 'package:test_app/features/app/presentation/view/pages/home_page.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/features/app/presentation/view/pages/q_and_a_page.dart';
import 'package:test_app/features/location_permission_page.dart';
import 'package:test_app/features/onboarding/presentation/controller/on_boarding_cubit.dart';
import 'package:test_app/features/onboarding/presentation/view/pages/main_page.dart';
import 'package:test_app/features/onboarding/presentation/view/pages/secondry_page.dart';
import 'package:test_app/features/splach_screen/view/pages/splash_screen.dart';
import 'package:test_app/features/app/presentation/view/pages/prayer_times_page.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RoutesConstants.secondryPageOnBoarding:
      return MaterialPageRoute<SecondryPage>(
        builder: (BuildContext context) => SecondryPage(),
      );
    case RoutesConstants.mainPageOnBoarding:
      return MaterialPageRoute<MainPage>(
        builder: (BuildContext context) => const MainPage(),
      );
    case RoutesConstants.homePageRouteName:
      return MaterialPageRoute<HomePage>(
        builder: (BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<TimerCubit>(),
            ),
            BlocProvider(
              create: (context) => sl<HadithCubit>(),
            ),
            BlocProvider(
              create: (context) => sl<PrayerTimesCubit>(),
            )
          ],
          child: const HomePage(),
        ),
      );
    case RoutesConstants.splashScreenRouteName:
      return MaterialPageRoute<SplashScreen>(
        builder: (BuildContext context) => SplashScreen(),
      );
    case RoutesConstants.qAndAPageRouteName:
      return MaterialPageRoute<QAndAPage>(
        builder: (BuildContext context) => const QAndAPage(),
      );
    case RoutesConstants.prayersTimePage:
      return MaterialPageRoute<PrayerTimesPage>(
        builder: (BuildContext context) => BlocProvider(
          create: (context) => sl<PrayerSoundSettingsCubit>(),
          child: const PrayerTimesPage(),
        ),
      );
    case RoutesConstants.locationPermissionPage:
      return MaterialPageRoute<LocationPermissionPage>(
        builder: (BuildContext context) => BlocProvider(
          create: (context) => OnBoardingCubit(),
          child: LocationPermissionPage(),
        ),
      );
    default:
      return MaterialPageRoute<Scaffold>(
        builder: (BuildContext context) => const Scaffold(),
      );
  }
}
