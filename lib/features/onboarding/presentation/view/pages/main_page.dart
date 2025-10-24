import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: context.height * 0.1),
          Image.asset(
            'assets/images/app_logo.png',
            height: context.height * 0.3,
          ),
          const SizedBox(height: 20),
          Text(
            AppStrings.translate("welcome"),
            style: TextStyles.semiBold16(context: context, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            AppStrings.translate("appName"),
            style: TextStyles.bold20(context).copyWith(
              fontSize: 40,
              color: Theme.of(context).primaryColor,
              fontFamily: 'normal',
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              AppStrings.translate("onBoardingText"),
              style: TextStyles.regular16_120(context,
                  color: AppColors.secondryColor),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ElevatedButton(
              child: Text(AppStrings.translate("startNow")),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesConstants.secondryPageOnBoarding,
                  (route) => false,
                );
              },
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
