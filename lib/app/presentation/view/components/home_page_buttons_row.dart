import 'package:flutter/material.dart';
import 'package:test_app/app/presentation/view/pages/alquran_alkarim_page.dart';
import 'package:test_app/app/presentation/view/pages/elec_rosary_page.dart';
import 'package:test_app/app/presentation/view/pages/rtabel_page.dart';
import 'package:test_app/core/constants/view_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class HomePageButtonsRow extends StatelessWidget {
  const HomePageButtonsRow({super.key});
  final int buttonsCount = 3;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 1 / 7, //same hight of button
      child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: List.generate(
              buttonsCount,
              (index) => _materialButton(
                  context: context,
                  text: ViewConstants.appBarTitles(withTwoLines: true)[index],
                  leftMargine: index != buttonsCount - 1
                      ? 16.0
                      : 0.0, //(leftMargine)spacing between buttons
                  page: _pages[index],
                  image: ViewConstants.imagesOfHomePageButtons[index]))),
    );
  }
}

_materialButton(
        {required BuildContext context,
        required String text,
        required double leftMargine,
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
        margin: EdgeInsets.only(left: leftMargine),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: AppColors.primaryColor,
        ),
        height: context.height * 1 / 7,
        width: context.width * .55,
        child: Row(
          spacing: 10.0,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style:
                  TextStyles.bold20(context).copyWith(color: AppColors.white,fontSize: 23),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                  width: context.width * 1 / 5,
                ),
              ),
            )
          ],
        ),
      ),
    );
const List<dynamic> _pages = <dynamic>[
  AlquranAlkarimPage(),
  ElecRosaryPage(),
  RamadanTabelPage()
];
