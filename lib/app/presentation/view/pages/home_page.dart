import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app/presentation/view/components/home_page_buttons_row.dart';
import 'package:test_app/app/presentation/view/components/home_page_drawer.dart';
import 'package:test_app/app/presentation/view/components/prayer_times_widget.dart';
import 'package:test_app/app/presentation/view/components/remaining_time_widget.dart';
import 'package:test_app/app/presentation/view/components/supplications_grid_view.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/timer/cubit/timer_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerCubit()..startTimerUntil('03:27:00'),
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: AppColors.thirdColor),
              backgroundColor: Colors.transparent,
            ),
            drawer: Padding(
              padding: EdgeInsets.only(
                  top: context.width * 1 / 3, bottom: context.width * 1 / 3),
              child: HomeDrawerWidget(),
            ),
            body: Padding(
              padding: EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 50.0,
                  children: [
                    PrayerTimesWidget(),
                    RemainingTimeWidget(),
                    HomePageButtonsRow(),
                    SupplicationsGridView(),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}



