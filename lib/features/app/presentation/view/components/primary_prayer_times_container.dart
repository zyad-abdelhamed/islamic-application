import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_prayer_times_controller.dart';
import 'package:test_app/features/app/presentation/view/components/next_prayer_widget.dart';

class PrimaryPrayerTimesContainer extends StatelessWidget {
  const PrimaryPrayerTimesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = sl<GetPrayersTimesController>();
    final timings = controller.timings;

    final List<String> prayerTimes = [
      timings.fajrArabic,
      timings.sunriseArabic,
      timings.dhuhrArabic,
      timings.asrArabic,
      timings.maghribArabic,
      timings.ishaArabic,
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: _boxDecoration(color: Theme.of(context).primaryColor),
      child: Column(
        children: <Widget>[
          // صف أوقات الصلاة
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: _getRowOfPrayers(context, textList: prayerTimes),
          ),

          // الحاوية الداخلية
          Container(
            height: 160,
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 20.0,left: 5.0,right: 5.0),
            decoration: _boxDecoration(
              color: ThemeCubit.controller(context).state
                  ? AppColors.darkModeInActiveColor
                  : AppColors.lightModeInActiveColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // أيقونة + اسم الصلاة
                _getRowOfIconsWithText(
                  context,
                  icons: AppStrings.translate("iconsOfTimings"),
                  names: AppStrings.translate("namesOfPrayers1"),
                ),

                const Spacer(),

                // الصلاة القادمة
                const NextPrayerWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _getRowOfPrayers(BuildContext context, {required List textList}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        textList.length,
        (index) => Expanded(
          child: Text(
            textList[index],
            textAlign: TextAlign.center,
            style: _dataTextStyle,
          ),
        ),
      ),
    );
  }

  TextStyle get _dataTextStyle {
    return const TextStyle(
          color: AppColors.white,
          fontFamily: 'Amiri',
          fontSize: 20.0,
          fontWeight: FontWeight.bold
        );
  }

  Row _getRowOfIconsWithText(BuildContext context, {
    required List icons,
    required List names,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        icons.length,
        (index) => Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                icons[index],
                height: 25,
                width: 25,
                color: AppColors.white,
              ),
              const SizedBox(height: 5),
              Text(
                names[index],
                style: _dataTextStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration({required Color color}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(35.0),
      color: color,
    );
  }
}