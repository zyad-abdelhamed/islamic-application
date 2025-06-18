import 'package:flutter/cupertino.dart';
import 'package:test_app/core/helper_function/get_widget_depending_on_reuest_state.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayer_times_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/remaining_time_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class PrayerTimesWidget extends StatelessWidget {
  const PrayerTimesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
      builder: (context, state) {
        return getWidgetDependingOnReuestState(
            requestStateEnum: state.requestStateofPrayerTimes,
            widgetIncaseSuccess: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 10.0),
                  margin: const EdgeInsets.only(bottom: 10.0), //spacing
                  decoration: _boxDecoration(color: AppColors.primaryColor),
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: _getRowOfPrayers(context,
                              textList: state.prayerTimes)),
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: _boxDecoration(
                            color: AppColors.inActivePrimaryColor),
                        padding: EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 10.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _getRowOfPrayers(context,
                                textList: AppStrings.namesOfPrayers1),
                            _getRowOfPrayers(context,
                                textList: AppStrings.emojisOfPrayers),
                            Spacer(),
                            Row(spacing: 5.0, children: [
                              textNextPrayer(
                                  context: context,
                                  text: AppStrings.nextPrayer),
                              textNextPrayer(
                                  context: context, text: state.nextPrayer.name)
                            ])
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                RemainingTimeWidget(),
              ],
            ),
            erorrMessage: state.errorMessageofPrayerTimes);
      },
    );
  }

  Row _getRowOfPrayers(BuildContext context, {required List<String> textList}) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List<Text>.generate(
          6,
          (index) => Text(
            textList[index],
            textAlign: TextAlign.center,
            style: TextStyles.bold20(context).copyWith(color: AppColors.white),
          ),
        ));
  }

  Text textNextPrayer({required BuildContext context, required String text}) {
    return Text(
      text,
      style: TextStyles.bold20(context).copyWith(
          color: AppColors.secondryColor,
          shadows: [
            BoxShadow(
                spreadRadius: 2,
                offset: const Offset(-5.0, -5.0),
                color: AppColors.purple.withValues(alpha: 0.2))
          ],
          fontSize: 28),
    );
  }
}

BoxDecoration _boxDecoration({required Color color}) =>
    BoxDecoration(borderRadius: BorderRadius.circular(35.0), color: color);
