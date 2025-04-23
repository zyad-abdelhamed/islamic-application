import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/orentation_layout.dart';
import 'package:test_app/core/constants/view_constants.dart';
import 'package:test_app/core/utils/sized_boxs.dart';
import 'package:test_app/features/app/presentation/controller/cubit/home_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_buttons_row.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_drawer.dart';
import 'package:test_app/features/app/presentation/view/components/land_scape_to_home_page.dart';
import 'package:test_app/features/app/presentation/view/components/prayer_times_widget.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_custom_grid_view.dart';
import 'package:test_app/core/adaptive/adaPtive_layout.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/splash_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TimerCubit()),
          BlocProvider(create: (context) => HomeCubit(sl(), sl())),
        ],
        child: AdaptiveLayout(
          mobileLayout: (context) => HomeMobileLayout(),
          tabletLayout: (context) => HomeMobileLayout(),
          desktopLayout: (context) => HomePageDesktopLayout(),
        ));
  }
}


class HomePageDesktopLayout extends StatelessWidget {
  const HomePageDesktopLayout({
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
                            ViewConstants.pages.length,
                            (index) => homeButton(
                                context: context,
                                text: ViewConstants.appBarTitles(
                                    withTwoLines: true)[index],
                                leftMargine: index !=
                                        ViewConstants.pages.length - 1
                                    ? 16.0
                                    : 0.0, //(leftMargine)spacing between buttons
                                page: ViewConstants.pages[index],
                                image: ViewConstants
                                    .imagesOfHomePageButtons[index])))
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class HomeMobileLayout extends StatelessWidget {
  const HomeMobileLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OrentationLayout(
        landScapeWidget: (context) => LandScapeToHomePage(),
        portraitWidget: (context) => Scaffold(
              appBar: AppBar(
                title: Text('الصفحة الرئيسية'),
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
                      HomePageButtonsRow(),
                      AdhkarCustomGridView(crossAxisCount: 2),
                    ],
                  ),
                ),
              ),
            ));
  }
}
