import 'package:flutter/material.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/presentation/controller/controllers/next_prayer_controller.dart';
import 'package:test_app/features/app/presentation/view/components/daily_adhkar_list_view.dart';
import 'package:test_app/features/app/presentation/view/components/home_buttons_list_view.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_drawer.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/presentation/view/components/prayer_times_widget.dart';

class HomePageToAndroidAndIos extends StatelessWidget {
  const HomePageToAndroidAndIos({
    super.key,
    required this.nextPrayerController,
    required this.scaffoldKey,
  });

  final NextPrayerController nextPrayerController;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final bool isPortraitOrientation =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(child: HomeDrawerWidget()),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
              title: Text(AppStrings.translate("mainPage")),
              floating: true, // يبان أول ما تسكرول لفوق
              snap: true, // حركة سريعة
              leading: IconButton(
                onPressed: () => scaffoldKey.currentState?.openDrawer(),
                icon: Column(
                  spacing: 3,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                      3,
                      (i) => Container(
                            width: i == 0 ? 20 : 15,
                            height: 3,
                            color: Color(0xFF004D40),
                          )),
                ),
              )),

          /// ========== Stories ==========
          SliverToBoxAdapter(
            child: DailyAdhkarListView(),
          ),

          const SliverPadding(padding: EdgeInsets.only(top: 20)),

          /// ========== Prayer Times ==========
          SliverToBoxAdapter(
            child: SizedBox(
              width: isPortraitOrientation
                  ? double.infinity
                  : (context.width * 3 / 4) - 20,
              child:
                  PrayerTimesWidget(nextPrayerController: nextPrayerController),
            ),
          ),

          const SliverPadding(padding: EdgeInsets.only(top: 20)),

          /// ========== Home Buttons ==========
          const SliverToBoxAdapter(
            child: HomeButtonsListView(),
          ),
        ],
      ),
    );
  }
}
