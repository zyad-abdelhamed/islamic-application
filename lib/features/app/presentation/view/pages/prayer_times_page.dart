import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/core/utils/sized_boxs.dart';
import 'package:test_app/features/app/presentation/controller/controllers/prayer_times_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_prayer_times_of_month_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/change_location_widget.dart';
import 'package:test_app/features/app/presentation/view/components/get_prayer_times_of_month_button.dart';
import 'package:test_app/features/app/presentation/view/components/prayer_times_of_month_widget.dart';

class PrayerTimesPage extends StatefulWidget {
  const PrayerTimesPage({super.key});

  @override
  State<PrayerTimesPage> createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage> {
  late final PrayerTimesPageController prayerTimesPageController;

  @override
  void initState() {
    prayerTimesPageController = PrayerTimesPageController();
    prayerTimesPageController.initState(context);
    super.initState();
  }

  @override
  void dispose() {
    prayerTimesPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GetPrayerTimesOfMonthCubit>(),
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesConstants.homePageRouteName,
            (route) => false,
          );
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("مواقيت الصلاه"),
            leading: GetAdaptiveBackButtonWidget(),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ChangeLocationWidget(),
                const SizedBox(height: 50),
                GetPrayerTimesOfMonthButton(
                  prayerTimesPageController: prayerTimesPageController,
                ),
                SizedBoxs.sizedBoxH30,
                SizedBox(
                  height: (context.height * .50) - 50,
                  child: PrayerTimesOfMonthWidget(
                      prayerTimesPageController: prayerTimesPageController),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
