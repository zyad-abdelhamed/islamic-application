import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/app/presentation/controller/cubit/hadith_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayer_times_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_cubit.dart';
import 'package:test_app/features/app/presentation/view/pages/home_page.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/features/app/presentation/view/pages/q_and_a_page.dart';
import 'package:test_app/features/app/presentation/view/pages/prayers_time_settings.dart';
import 'package:test_app/features/onboarding/presentation/view/pages/main_page.dart';
import 'package:test_app/features/onboarding/presentation/view/pages/secondry_page.dart';
import 'package:test_app/features/splash_screen.dart';

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
        builder: (BuildContext context) => const SplashScreen(),
      );  
    case RoutesConstants.qAndAPageRouteName:
      return MaterialPageRoute<QAndAPage>(
        builder: (BuildContext context) =>  const QAndAPage(),
      );   
        builder: (BuildContext context) => SplashScreen(),
      );
    case RoutesConstants.prayersTimePageSettings:
      return MaterialPageRoute<PrayersTimeSettings>(
        builder: (BuildContext context) => PrayersTimeSettings(),
      );
     
    default:
      return MaterialPageRoute<Scaffold>(
        builder: (BuildContext context) => const Scaffold(),
      );
  }
}
