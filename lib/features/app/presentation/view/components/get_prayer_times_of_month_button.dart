import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/core/widgets/explain_feature_widget.dart';
import 'package:test_app/features/app/presentation/controller/controllers/prayer_times_page_controller.dart';

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
          onTap: () => prayerTimesPageController.sendButtonOnTap(context),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.primaryColorInActiveColor,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/send.png",
                  width: 40,
                  height: 40,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
        Container(
            width: context.width * 3 / 4,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: AppColors.primaryColorInActiveColor,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 5,
                  children: [
                    const Icon(Icons.calendar_month, color: Colors.grey),
                    Text(AppStrings.translate("chooseDate"),
                        style: TextStyle(color: Colors.grey)),
                    IconButton(
                      onPressed: () =>
                          prayerTimesPageController.selectDate(context),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        size: 35,
                      ),
                    ),
                    const Spacer(),
                    ExplainFeatureButton(
                        text:
                            AppStrings.translate("prayerTimesOfMonthInfoText")),
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
                                        (index) => DateContainer(
                                              text: prayerTimesPageController
                                                  .dateData[index],
                                              width: index == 2 ? 90 : 60,
                                            )),
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
                                      color:
                                          Colors.white.withValues(alpha: 0.5),
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
}

class DateContainer extends StatelessWidget {
  const DateContainer({
    super.key,
    required this.text,
    required this.width,
  });

  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 30,
        width: width,
        alignment: Alignment.center,
        child: Text(text,
            style: TextStyles.bold20(context).copyWith(color: Colors.white)));
  }
}
