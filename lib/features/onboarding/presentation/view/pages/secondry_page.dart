import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/onboarding/presentation/controller/on_boarding_cubit.dart';
import 'package:test_app/features/onboarding/presentation/view/component/on_boarding_button.dart';

class SecondryPage extends StatelessWidget {
  const SecondryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
              controller: sl<OnBoardingCubit>().pageController,
              itemCount: AppStrings.features.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  spacing: 90,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.white,
                      radius: 90,
                      child: Image.asset(
                        images[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      AppStrings.features[index],
                      style: TextStyles.semiBold32Decoreted(context,
                          color: AppColors.primaryColor(context)),
                    ),
                    Text(
                      AppStrings.texts[index],
                      style: TextStyles.semiBold16(
                          context: context, color: AppColors.secondryColor),
                    )
                  ],
                );
              },
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SmoothPageIndicator(
                controller: sl<OnBoardingCubit>().pageController,
                count: AppStrings.features.length,
                effect: ScrollingDotsEffect(
                  dotColor: AppColors.inActivePrimaryColor,
                  activeDotColor: AppColors.primaryColor(context),
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 8,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                onBoardingButton(
                  context: context,
                  name: AppStrings.next,
                  onPressed: () =>
                      sl<OnBoardingCubit>().animateToNextPage(context: context),
                ),
                TextButton(
                    onPressed: () {
                      sl<OnBoardingCubit>().goToHomePage(context: context);
                    },
                    child: Text(
                      AppStrings.skip,
                      style: TextStyles.semiBold16(
                          context: context, color: Colors.grey),
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

List<String> images = [
  "assets/images/prayer.png",
  'assets/images/اذكار.png',
  "assets/images/ramadan.png",
  'assets/images/quran.png',
  'assets/images/compass.png'
];
