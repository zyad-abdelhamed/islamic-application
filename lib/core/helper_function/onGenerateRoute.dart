import 'package:flutter/material.dart';
import 'package:test_app/features/app/presentation/view/pages/home_page.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/features/app/presentation/view/pages/q_and_a_page.dart';
import 'package:test_app/features/onboarding/presentation/view/pages/main_page.dart';
import 'package:test_app/features/onboarding/presentation/view/pages/secondry_page.dart';
import 'package:test_app/features/splash_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RoutesConstants.secondryPageOnBoarding:
      return MaterialPageRoute<SecondryPage>(
        builder: (BuildContext context) =>  SecondryPage(),
      );
    case RoutesConstants.mainPageOnBoarding:
      return MaterialPageRoute<MainPage>(
        builder: (BuildContext context) => const MainPage(),
      );
    case RoutesConstants.homePageRouteName:
      return MaterialPageRoute<HomePage>(
        builder: (BuildContext context) => const HomePage(),
      );
    case RoutesConstants.splashScreenRouteName:
      return MaterialPageRoute<SplashScreen>(
        builder: (BuildContext context) => const SplashScreen(),
      );  
    case RoutesConstants.qAndAPageRouteName:
      return MaterialPageRoute<QAndAPage>(
        builder: (BuildContext context) =>  const QAndAPage(),
      );   
    default:
      return MaterialPageRoute<Scaffold>(
        builder: (BuildContext context) => const Scaffold(),
      );
  }
}
