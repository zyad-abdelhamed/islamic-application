import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/adaptive_widgets/get_adaptive_loading_widget.dart';

class SplashScreen extends StatelessWidget {

  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    goToMainPage(context);
    return const ColoredBox(
      color: AppColors.primaryColor,
      child: Padding(
        padding: EdgeInsets.only(bottom: 100.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GetAdaptiveLoadingWidget(),
        ),
      ),
    );
  }

  void goToHomePage(BuildContext context) {
    Future.delayed(
        Duration(seconds: 2),
        () => Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesConstants.homePageRouteName,
              (route) => false,
            ));
  }
  void goToMainPage(BuildContext context) {
    Future.delayed(
        Duration(seconds: 2),
        () => Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesConstants.mainPageOnBoarding,
              (route) => false,
            ));
  }
}