import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/data/models/get_prayer_times_of_month_prameters.dart';
import 'package:test_app/features/app/presentation/controller/controllers/prayer_times_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_prayer_times_of_month_cubit.dart';

class GetPrayerTimesOfMonthButton extends StatelessWidget {
  const GetPrayerTimesOfMonthButton(
      {super.key, required this.prayerTimesPageController});

  final PrayerTimesPageController prayerTimesPageController;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15.0,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => GetPrayerTimesOfMonthCubit.controller(context)
              .getPrayerTimesOfMonth(GetPrayerTimesOfMonthPrameters(
                  date: prayerTimesPageController.dateNotifier.value)),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.inActivePrimaryColor,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.send,
                  color: AppColors.primaryColor,
                  size: 40,
                ),
              ],
            ),
          ),
        ),
        Container(
            width: context.width * 3 / 4,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: AppColors.inActivePrimaryColor,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 5,
                  children: [
                    Icon(Icons.calendar_month, color: Colors.grey),
                    Text("اختر التاريخ", style: TextStyle(color: Colors.grey)),
                    IconButton(
                        onPressed: () =>
                            prayerTimesPageController.selectDate(context),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey[300],
                          size: 35,
                        )),
                    Spacer(),
                    Icon(
                      Icons.info,
                      color: AppColors.primaryColor,
                      size: 35,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 30,
                      width: 60 * 4,
                      child: Stack(
                        children: <Widget>[
                          ValueListenableBuilder<DateTime>(
                              valueListenable:
                                  prayerTimesPageController.dateNotifier,
                              builder: (_, __, ___) => Row(
                                    children: List.generate(
                                        3,
                                        (index) => _dateContainer(context,
                                            text: prayerTimesPageController
                                                .dateData[index],
                                            width: index == 2 ? 90 : 60)),
                                  )),
                          Center(
                            child: SizedBox(
                              width: 60 * 3,
                              height: 30,
                              child: Row(
                                children: List.generate(
                                  2,
                                  (index) => SizedBox(
                                    height: 30,
                                    width: 60,
                                    child: VerticalDivider(
                                      thickness: 3,
                                      indent: 5,
                                      endIndent: 5,
                                      color: AppColors.white
                                          .withValues(alpha: 0.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }

  Container _dateContainer(BuildContext context,
      {required String text, required double width}) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 30,
        width: width,
        alignment: Alignment.center,
        child: Text(text,
            style: TextStyles.bold20(context).copyWith(color: Colors.white)));
  }
}
