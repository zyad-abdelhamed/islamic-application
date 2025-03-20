
import 'package:flutter/material.dart';
import 'package:test_app/app/presentation/view/pages/home_page.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/splash_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RoutesConstants.homePageRouteName:
      return MaterialPageRoute<HomePage>(
        builder: (BuildContext context) => const HomePage(),
      );
    case RoutesConstants.splashScreenRouteName:
      return MaterialPageRoute<SplashScreen>(
        builder: (BuildContext context) =>  SplashScreen(),
      );  
    default:
      return MaterialPageRoute<Scaffold>(
        builder: (BuildContext context) => const Scaffold(),
      );
  }
}
