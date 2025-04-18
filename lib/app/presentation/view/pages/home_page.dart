import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app/presentation/controller/cubit/prayer_times_cubit.dart';
import 'package:test_app/app/presentation/view/components/home_page_buttons_row.dart';
import 'package:test_app/app/presentation/view/components/home_page_drawer.dart';
import 'package:test_app/app/presentation/view/components/prayer_times_widget.dart';
import 'package:test_app/app/presentation/view/components/supplications_custom_grid_view.dart';
import 'package:test_app/core/adaptive_widgets/adaPtive_layout.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/splash_screen.dart';
import 'package:test_app/timer/cubit/timer_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        // ignore: deprecated_member_use
        providers: [
          BlocProvider(
              create: (context) => TimerCubit()),
          BlocProvider(
              create: (context) => PrayerTimesCubit(sl())..getPrayersTimes(context)),
        ],
        child: WillPopScope(
          // زيها زى dispose in stateful widget علشان عامل dispose to timer ميحصلش اهدار للمصادر زى animation controller  لو متعملوش مثلا dispose
          onWillPop: () async {
            context.read<TimerCubit>().stopTimer(); // إيقاف المؤقت
            return true; // السماح بالخروج
          },
          child: AdaptiveLayout(
            mobileLayout: (context) => HomeMobileAndTabletLayout(),
            tabletLayout: (context) => HomeMobileAndTabletLayout(),
            desktopLayout: (context) => HomeWindowsLayout(),
          ),
        ));
  }
}

class HomeMobileAndTabletLayout extends StatelessWidget {
  const HomeMobileAndTabletLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        
        Scaffold(

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
          child: HomeDrawerWidget()
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8, top: 40),
            child: SingleChildScrollView(
              child: Column(
                spacing: 50.0,
                children: [
                  PrayerTimesWidget(width: double.infinity,),
                  HomePageButtonsRow(),
                  SupplicationsCustomGridView(),
                ],
              ),
            ),
          ),
        ),
           SplashScreen()

      ],
    );
  }
}

class HomeWindowsLayout extends StatelessWidget {
  const HomeWindowsLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8, top: 40),
        child: Row(
          children: [
            HomeDrawerWidget(),
            VerticalDivider(),Spacer()
            // Column(
            //   spacing: 50.0,
            //   children: [
            //     Row(
            //       children: [
            //         Expanded(child: PrayerTimesWidget(width: 300,)),
            //                           Expanded(child: SupplicationsCustomGridView()),
            //       ],
            //     ),
        
            //     HomePageButtonsRow(),
            //   ],
            // ),
          ],
        ),
    );
  }
}
