import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/onboarding/presentation/view/component/on_boarding_button.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    const double radius = 80;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Spacer(),
              Container(
                width: double.infinity,
                height: context.height * .6,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(45)),
                    color: AppColors.primaryColor),
                child: Column(
                  spacing: 50,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Islamic App',
                      style: TextStyles.semiBold32Decoreted(context,
                          color: AppColors.white),
                    ),
                    Text(
                        'نبدأ باسم الله... دليلك اليومي للسكينة، والذكر، والقرب من الله. ',
                        style: TextStyles.semiBold16(
                            context: context, color: AppColors.white)),
                    onBoardingButton(
                      context: context,
                      name: 'ابدأ',
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RoutesConstants.secondryPageOnBoarding,
                          (route) => false,
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: context.height * .6 - radius ,
            left: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: AppColors.thirdColor,
              radius:radius,
              child: SvgPicture.asset('assets/images/Vector.svg'),
            ),
          )
        ],
      ),
    );
  }


}
