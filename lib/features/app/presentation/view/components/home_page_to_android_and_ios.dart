import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_grid_view.dart';
import 'package:test_app/features/app/presentation/view/components/home_button.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_drawer.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/presentation/view/components/prayer_times_widget.dart';

class HomePageToAndroidAndIos extends StatelessWidget {
  const HomePageToAndroidAndIos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPortraitOrientation =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.mainPage),
        actions: [
          Builder(builder: (context) {
            return IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: Icon(CupertinoIcons.profile_circled));
          })
        ],
      ),
      drawer: Drawer(child: HomeDrawerWidget()),
      endDrawer: Drawer(
       
        backgroundColor: ThemeCubit.controller(context).state ? AppColors.black : AppColors.white,
        shape: LinearBorder(),
        child: SizedBox()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 30.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: isPortraitOrientation
                    ? double.infinity
                    : (context.width * 3 / 4) - 20,
                child: PrayerTimesWidget()),
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
                          image: AppStrings.imagesOfHomePageButtons[index]))),
            ),
            AdhkarGridView(crossAxisCount: isPortraitOrientation ? 2 : 4)
          ],
        ),
      )
    );
  }
}
