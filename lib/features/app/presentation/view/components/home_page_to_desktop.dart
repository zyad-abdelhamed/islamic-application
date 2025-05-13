import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/utils/sized_boxs.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_custom_grid_view.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_buttons_row.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_drawer.dart';
import 'package:test_app/features/app/presentation/view/components/prayer_times_widget.dart';

class HomePageToDesktop extends StatelessWidget {
  const HomePageToDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
            preferredSize: Size(double.infinity, 130),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: AdhkarCustomGridView(crossAxisCount: 8),
            )),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 30.0,
        children: [
          Expanded(child: SafeArea(child: HomeDrawerWidget())),
          Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBoxs.sizedBoxH30,
                    SizedBox(width: 450, child: PrayerTimesWidget()),
                    Spacer(),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            AppStrings.pages.length,
                            (index) => homeButton(
                                context: context,
                                text: AppStrings.appBarTitles(
                                    withTwoLines: true)[index],
                                leftMargin: index !=
                                        AppStrings.pages.length - 1
                                    ? 16.0
                                    : 0.0, //(leftMargine)spacing between buttons
                                page: AppStrings.pages[index],
                                image: AppStrings
                                    .imagesOfHomePageButtons[index])))
                  ],
                ),
              )),
        ],
      ),
    );
  }
}