import 'package:flutter/material.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_button.dart';
import 'package:test_app/features/app/presentation/view/components/home_button.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_drawer.dart';
import 'package:test_app/features/app/presentation/view/components/land_scape_to_home_page.dart';
import 'package:test_app/features/app/presentation/view/components/prayer_times_widget.dart';
import 'package:test_app/core/adaptive/orentation_layout.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/presentation/view/pages/adhkar_page.dart';

class HomePageToAndroidAndIos extends StatelessWidget {
  const HomePageToAndroidAndIos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OrentationLayout(
        landScapeWidget: (context) => LandScapeToHomePage(),
        portraitWidget: (context) => Scaffold(
              appBar: AppBar(
                title: Text(AppStrings.mainPage),
              ),
              drawer: Padding(
                padding: EdgeInsets.only(
                    top: context.width * 1 / 3, bottom: context.width * 1 / 3),
                child: Drawer(
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(double.infinity),
                            bottomLeft: Radius.circular(double.infinity))),
                    child: HomeDrawerWidget()),
              ),
              body: Padding(
                padding:
                    EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8, top: 40),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 50.0,
                    children: [
                      PrayerTimesWidget(),
                      SizedBox(
                        height: 100, //same hight of button
                        child: ListView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                                AppStrings.pages.length,
                                (index) => HomeButton(
                                    text: AppStrings.appBarTitles(
                                        withTwoLines: true)[index],
                                    index: index,
                                    page: AppStrings.pages[index],
                                    image: AppStrings
                                        .imagesOfHomePageButtons[index]))),
                      ),
                      GridView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15),
                          children: List<AdhkarButton>.generate(
                              8,
                              (index) => AdhkarButton(
                                    icon: AppStrings.supplicationIcons[index],
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AdhkarPage(
                                                nameOfAdhkar: AppStrings
                                                        .supplicationsButtonsNames[
                                                    index]),
                                          ));
                                    },
                                    text: AppStrings
                                        .supplicationsButtonsNames[index],
                                  ))),
                    ],
                  ),
                ),
              ),
            ));
  }
}
