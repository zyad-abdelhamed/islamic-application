import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/widgets/get_adaptive_loading_widget.dart';

class SplashScreen extends StatelessWidget {
  // final random = Random();

  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    _goToHomePage(context);
    // final randomIndex = random.nextInt(ran.length);
    // final randomItem = ran[randomIndex];
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

  void _goToHomePage(BuildContext context) {
    Future.delayed(
        Duration(seconds: 2),
        () => Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesConstants.homePageRouteName,
              (route) => false,
            ));
  }
}
// ListTile(
//                 title: const Text(
//                   'حديث اليوم|',
//                   style: TextStyle(
//                       color: Colors.amber,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 25),
//                 ),
//                 subtitle: Text(
//                   randomItem,
//                   style: const TextStyle(color: Colors.white, fontSize: 19),
//                 ),
//             )
