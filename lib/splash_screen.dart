import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app/presentation/controller/cubit/prayer_times_cubit.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class SplashScreen extends StatelessWidget {
  // final random = Random();

  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
   // _goToMainPage(context);
    // final randomIndex = random.nextInt(ran.length);
    // final randomItem = ran[randomIndex];
    return BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
      builder: (context, state) {
        return Visibility(
          visible: state.requestStateofPrayerTimes == RequestStateEnum.loading,
          child:  ColoredBox(
            color: AppColors.primaryColor,
            child: Padding(
              padding: EdgeInsets.only(bottom: 100.0,top:context.height*3/4 ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GetAdaptiveLoadingWidget(),
              ),
            ),
          ),
        );
      },
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

  void _goToMainPage(BuildContext context) {
    Future.delayed(
        Duration(seconds: 2),
        () => Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesConstants.mainPageOnBoarding,
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
