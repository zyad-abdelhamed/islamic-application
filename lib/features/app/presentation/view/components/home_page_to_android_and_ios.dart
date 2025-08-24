import 'package:flutter/material.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayer_times_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_grid_view.dart';
import 'package:test_app/features/app/presentation/view/components/daily_adhkar_list_view.dart';
import 'package:test_app/features/app/presentation/view/components/home_buttons_list_view.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_drawer.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/presentation/view/components/prayer_times_widget.dart';

class HomePageToAndroidAndIos extends StatelessWidget {
  const HomePageToAndroidAndIos({
    super.key,
    required this.nextPrayerController,
  });

  final NextPrayerController nextPrayerController;

  @override
  Widget build(BuildContext context) {
    final bool isPortraitOrientation =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.translate("mainPage")),
      ),
      drawer: Drawer(child: HomeDrawerWidget()),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
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
                child: PrayerTimesWidget(
                    nextPrayerController: nextPrayerController),
              ),
            ),

            const SliverPadding(padding: EdgeInsets.only(top: 20)),

            /// ========== Home Buttons ==========
            SliverToBoxAdapter(
              child: HomeButtonsListView(),
            ),

            const SliverPadding(padding: EdgeInsets.only(top: 20)),

            /// ========== Grid ==========
            SliverToBoxAdapter(
              child: AdhkarGridView(
                crossAxisCount: isPortraitOrientation ? 2 : 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
