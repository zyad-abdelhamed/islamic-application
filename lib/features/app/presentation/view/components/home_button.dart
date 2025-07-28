import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class HomeButton extends StatelessWidget {
  const HomeButton(
      {super.key,
      required this.text,
      required this.index,
      required this.page,
      required this.image});

  final String text;
  final int index;
  final dynamic page;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => WillPopScope(
                onWillPop: () async {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RoutesConstants.homePageRouteName,
                    (route) => false,
                  );
                  return false;
                },
                child: page,
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(
            left: index != AppStrings.pages.length - 1
                ? 16.0
                : 0.0), //(leftMargine)spacing between buttons

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
  }
}
