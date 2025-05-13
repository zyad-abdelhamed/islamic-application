import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class HomePageButtonsRow extends StatelessWidget {
  const HomePageButtonsRow({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, //same hight of button
      child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: List.generate(
              AppStrings.pages.length,
              (index) => homeButton(
                  context: context,
                  text: AppStrings.appBarTitles(withTwoLines: true)[index],
                  leftMargin: index != AppStrings.pages.length - 1
                      ? 16.0
                      : 0.0, //(leftMargine)spacing between buttons
                  page: AppStrings.pages[index],
                  image: AppStrings.imagesOfHomePageButtons[index]))),
    );
  }
}

homeButton(
        {required BuildContext context,
        required String text,
        required double leftMargin,
        required dynamic page,
        required String image}) =>
    GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ));
      },
      child: Container(
        margin: EdgeInsets.only(left: leftMargin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: AppColors.primaryColor,
        ),
        height: 100,
        width: 200,
        child: Row(
          spacing: 10.0,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyles.bold20(context)
                  .copyWith(color: AppColors.white, fontSize: 23),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                  width: 200 - 120,
                ),
              ),
            )
          ],
        ),
      ),
    );
