import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/onboarding/presentation/controller/on_boarding_controller.dart';
import 'package:test_app/features/onboarding/presentation/view/component/feature_description_widget.dart';
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
    final OnBoardingController onBoardingController =
        sl<OnBoardingController>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: onBoardingController.featuresNumber,
                itemBuilder: (context, index) {
                  return FeatureDescriptionWidget(
                    image: AppStrings.translate("imagesOfOnBorading")[index],
                    imageColor: index == 2 ? Colors.white : null,
                    title: AppStrings.translate("features")[index],
                    description:
                        AppStrings.translate("textsOfOnBorading")[index],
                  );
                },
              ),
            ),
            SmoothPageIndicator(
              controller: pageController,
              count: onBoardingController.featuresNumber,
              effect: ScrollingDotsEffect(
                maxVisibleDots: onBoardingController.featuresNumber,
                dotColor: AppColors.primaryColorInActiveColor,
                activeDotColor: Theme.of(context).primaryColor,
                dotHeight: 10,
                dotWidth: 10,
                spacing: 8,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                onBoardingButton(
                  context: context,
                  name: AppStrings.translate("next"),
                  onPressed: () => onBoardingController.toNextPage(
                    context: context,
                    controller: pageController,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    onBoardingController.goToLocationPermissionPage(
                        context: context);
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
