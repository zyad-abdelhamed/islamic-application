import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widget_depending_on_os.dart';
import 'package:test_app/core/adaptive/orentation_layout.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/presentation/controller/cubit/home_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/timer_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_to_desktop.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_buttons_row.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_drawer.dart';
import 'package:test_app/features/app/presentation/view/components/land_scape_to_home_page.dart';
import 'package:test_app/features/app/presentation/view/components/prayer_times_widget.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_custom_grid_view.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TimerCubit()),
          BlocProvider(create: (context) => HomeCubit(sl(), sl())),
        ],
        child: adaptiveWidgetDependingOnOs(defaultWidget: HomePageToDesktop(), androidWidget: HomePageToAndroidAndIos(), iosWidget: HomePageToAndroidAndIos()));
  }
}

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
                      HomePageButtonsRow(),
                      AdhkarCustomGridView(crossAxisCount: 2),
                    ],
                  ),
                ),
              ),
            ));
  }
}
