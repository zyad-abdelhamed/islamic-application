import 'package:flutter/material.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/core/utils/sized_boxs.dart';
import 'package:test_app/features/app/presentation/controller/controllers/prayer_times_page_controller.dart';
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
    prayerTimesPageController.initState();
    super.initState();
  }

  @override
  void dispose() {
    prayerTimesPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("مواقيت الصلاه"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ChangeLocationWidget(),
            const SizedBox(height: 50),
            GetPrayerTimesOfMonthButton(prayerTimesPageController: prayerTimesPageController,),
            SizedBoxs.sizedBoxH30,
            SizedBox(
              height: (context.height * .50) - 100,
              child: PrayerTimesOfMonthWidget(
                  prayerTimesPageController: prayerTimesPageController),
            ),
          ],
        ),
      ),
    );
  }
}
