import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/helper_function/get_widget_depending_on_reuest_state.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/presentation/controller/controllers/prayer_times_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_prayer_times_of_month_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/secondry_prayer_times_widget.dart';

class PrayerTimesOfMonthWidget extends StatelessWidget {
  const PrayerTimesOfMonthWidget(
      {super.key, required this.prayerTimesPageController});

  final PrayerTimesPageController prayerTimesPageController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPrayerTimesOfMonthCubit, GetPrayerTimesOfMonthState>(
      builder: (context, state) {
        return getWidgetDependingOnReuestState(
            requestStateEnum: state.getPrayerTimesOfMonthState!,
            widgetIncaseSuccess: _widgetInCaseSucces(state.prayerTimesOfMonth),
            erorrMessage: state.getPrayerTimesOfMonthErrorMeassage);
      },
    );
  }

  Row _widgetInCaseSucces(List<Timings> listOfTimings) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _swapButton(
            iconData: CupertinoIcons.chevron_right,
            onPressed: () => prayerTimesPageController.animateTopreviousPage(),
            visibleNotifier:
                prayerTimesPageController.previousButtonVisibleNotifier),
        Expanded(
          child: PageView.builder(
            controller: prayerTimesPageController.pageController,
            onPageChanged: prayerTimesPageController.onPageChanged,
            itemCount: listOfTimings.length,  
            itemBuilder: (context, index) =>
                SecondaryPrayerTimesWidget(timings: listOfTimings[index]),
          ),
        ),
        _swapButton(
            iconData: CupertinoIcons.chevron_left,
            onPressed: () => prayerTimesPageController.animateToNextPage(),
            visibleNotifier:
                prayerTimesPageController.nextButtonVisibleNotifier),
      ],
    );
  }

  ValueListenableBuilder<bool> _swapButton(
      {required IconData iconData,
      required void Function() onPressed,
      required ValueNotifier<bool> visibleNotifier}) {
    return ValueListenableBuilder<bool>(
        valueListenable: visibleNotifier,
        builder: (_, __, ___) {
          return Visibility(
            visible: visibleNotifier.value,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: IconButton(
                onPressed: onPressed,
                icon: Icon(iconData, size: 35, color: AppColors.primaryColor)),
          );
        });
  }
}
