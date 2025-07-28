import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';

class PrayerTimesPageController {
  late final PageController pageController;
  late final int itemCount;
  late final ValueNotifier<bool> nextButtonVisibleNotifier;
  late final ValueNotifier<bool> previousButtonVisibleNotifier;
  late final ValueNotifier<DateTime> dateNotifier;

  initState() {
    itemCount = 2;
    pageController = PageController();
    nextButtonVisibleNotifier = ValueNotifier<bool>(true);
    previousButtonVisibleNotifier = ValueNotifier<bool>(false);
    dateNotifier = ValueNotifier<DateTime>(DateTime.now());
  }

  dispose() {
    pageController.dispose();
    nextButtonVisibleNotifier.dispose();
    previousButtonVisibleNotifier.dispose();
  }

  List<String> get dateData => <String>[
        dateNotifier.value.day.toString(),
        dateNotifier.value.month.toString(),
        dateNotifier.value.year.toString()
      ];

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: dateNotifier.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (pickedDate != null) {
      dateNotifier.value = pickedDate;
    }
  }

  void onPageChanged(int value) {
    if (value == 0) {
      previousButtonVisibleNotifier.value = false;
    } else if (value == itemCount) {
      nextButtonVisibleNotifier.value = false;
    } else {
      if (!previousButtonVisibleNotifier.value) {
        previousButtonVisibleNotifier.value = true;
      }
      if (!nextButtonVisibleNotifier.value) {
        nextButtonVisibleNotifier.value = true;
      }
    }
  }

  animateToNextPage() {
    pageController.nextPage(
        duration: AppDurations.lowDuration, curve: Curves.linear);
  }

  animateTopreviousPage() {
    pageController.previousPage(
        duration: AppDurations.lowDuration, curve: Curves.linear);
  }
}
