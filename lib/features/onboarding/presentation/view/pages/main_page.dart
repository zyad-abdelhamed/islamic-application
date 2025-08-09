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
      backgroundColor: Theme.of(context).primaryColor,
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
                    color: AppColors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Application',
                      style: TextStyles.regular16_120(context,
                          color: Colors.black),
                    ),
                    Text(
                      '        Islamic',
                      style: TextStyles.bold20(
                        context,
                      ).copyWith(color: Theme.of(context).primaryColor, fontSize: 45),
                    ),
                    const SizedBox(height: 50.0),
                    Text(
                        'نبدأ باسم الله... دليلك اليومي للسكينة، والذكر، والقرب من الله. ',
                        style: TextStyles.semiBold16(
                            context: context, color: AppColors.secondryColor)),
                    const SizedBox(height: 50.0),
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
            bottom: context.height * .6 - radius,
            left: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: AppColors.errorColor,
              radius: radius,
              child: SvgPicture.asset(
                'assets/images/Vector.svg',
              ),
            ),
          )
        ],
      ),
    );
  }
}
