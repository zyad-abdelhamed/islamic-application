import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app/presentation/controller/cubit/prayer_times_cubit.dart';
import 'package:test_app/app/presentation/view/components/home_page_buttons_row.dart';
import 'package:test_app/app/presentation/view/components/home_page_drawer.dart';
import 'package:test_app/app/presentation/view/components/prayer_times_widget.dart';
import 'package:test_app/app/presentation/view/components/supplications_custom_grid_view.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/timer/cubit/timer_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        // ignore: deprecated_member_use
        providers: [
          BlocProvider(
              create: (context) => TimerCubit(sl())..getRemainingTime()),
          BlocProvider(
              create: (context) => PrayerTimesCubit(sl())..getPrayersTimes()),
        ],
        child: WillPopScope(
          // زيها زى dispose in stateful widget علشان عامل dispose to timer ميحصلش اهدار للمصادر زى animation controller  لو متعملوش مثلا dispose
          onWillPop: () async {
            context.read<TimerCubit>().stopTimer(); // إيقاف المؤقت
            return true; // السماح بالخروج
          },
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: Text('الصفحة الرئيسية'),
              ),
              drawer: Padding(
                padding: EdgeInsets.only(
                    top: context.width * 1 / 3, bottom: context.width * 1 / 3),
                child: HomeDrawerWidget(),
              ),
              body: Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0,bottom: 8,top: 40),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 50.0,
                    children: [
                      PrayerTimesWidget(),
                      HomePageButtonsRow(),
                      SupplicationsCustomGridView(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class HomeCustomBottomNavigationBar extends StatelessWidget {
  const HomeCustomBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
          AppColors.grey,
          AppColors.grey.withValues(alpha: .5),
          AppColors.grey.withValues(alpha: 0.0),
        ])
      ),
    );
  }
}





