import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/onboarding/presentation/controller/on_boarding_cubit.dart';
import 'package:test_app/features/onboarding/presentation/view/component/on_boarding_button.dart';

class SecondryPage extends StatefulWidget {
  const SecondryPage({super.key});

  @override
  State<SecondryPage> createState() => _SecondryPageState();
}

class _SecondryPageState extends State<SecondryPage> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = sl<OnBoardingCubit>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: AppStrings.translate("features").length,
                itemBuilder: (context, index) {
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
                        AppStrings.translate("features")[index],
                        style: TextStyles.semiBold32Decoreted(
                          context,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        AppStrings.translate("textsOfOnBorading")[index],
                        style: TextStyles.semiBold16(
                          context: context,
                          color: AppColors.secondryColor,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SmoothPageIndicator(
                controller: pageController,
                count: AppStrings.translate("features").length,
                effect: ScrollingDotsEffect(
                  dotColor: ThemeCubit.controller(context).state
                      ? AppColors.darkModeInActiveColor
                      : AppColors.lightModeInActiveColor,
                  activeDotColor: Theme.of(context).primaryColor,
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
                  name: AppStrings.translate("next"),
                  onPressed: () => cubit.toNextPage(
                    context: context,
                    controller: pageController,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    cubit.goToHomePage(context: context);
                  },
                  child: Text(
                    AppStrings.translate("skip"),
                    style: TextStyles.semiBold16(
                      context: context,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
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
