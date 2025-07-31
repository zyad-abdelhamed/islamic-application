import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/features/app/data/models/get_prayer_times_of_month_prameters.dart';
import 'package:test_app/features/app/presentation/controller/controllers/cubit/location_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_prayer_times_of_month_cubit.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/internet_connection.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/features/app/presentation/view/components/show_location_dialog.dart';

class PrayerTimesPageController {
  late PageController pageController;
  late final ValueNotifier<bool> nextButtonVisibleNotifier;
  late final ValueNotifier<bool> previousButtonVisibleNotifier;
  late final ValueNotifier<DateTime> dateNotifier;
  final ValueNotifier<bool> loadUpdateLocationDialogNotifier =
      ValueNotifier<bool>(false);

  late final ValueNotifier<bool> internetConnectionNotifier;
  late final ValueNotifier<bool> isLocationEnabledNotifier;

  initState(BuildContext context) async {
    pageController = PageController(initialPage: DateTime.now().day - 1);
    dateNotifier = ValueNotifier<DateTime>(DateTime.now());

    previousButtonVisibleNotifier =
        ValueNotifier<bool>(_getPreviousButtonNotifierValue);
    nextButtonVisibleNotifier =
        ValueNotifier<bool>(_getNextButtonNotifierValue);
    internetConnectionNotifier = ValueNotifier<bool>(
        await sl<InternetConnection>().checkInternetConnection());
    isLocationEnabledNotifier =
        ValueNotifier<bool>(await sl<BaseLocationService>().isServiceEnabled);

    isLocationEnabledNotifier.addListener(() async => isLocationEnabledNotifier
        .value = await sl<BaseLocationService>().isServiceEnabled);
        print(await sl<BaseLocationService>().isServiceEnabled);
  }

  dispose() {
    pageController.dispose();
    nextButtonVisibleNotifier.dispose();
    previousButtonVisibleNotifier.dispose();
    loadUpdateLocationDialogNotifier.dispose();
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

  void sendButtonOnTap(BuildContext context) {
    pageController = PageController(
        //reinitialize pageController object to set init page value
        initialPage: dateNotifier.value.day - 1);
    previousButtonVisibleNotifier.value = _getPreviousButtonNotifierValue;
    nextButtonVisibleNotifier.value = _getNextButtonNotifierValue;
    GetPrayerTimesOfMonthCubit.controller(context).getPrayerTimesOfMonth(
        GetPrayerTimesOfMonthPrameters(date: dateNotifier.value));
  }

  bool get _getNextButtonNotifierValue => dateNotifier.value.day - 1 != 30;
  bool get _getPreviousButtonNotifierValue => dateNotifier.value.day - 1 != 0;

  void onPageChanged(BuildContext context, int value) {
    if (value == 0) {
      previousButtonVisibleNotifier.value = false;
    } else if (value == _itemCount(context)) {
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

  int _itemCount(BuildContext context) =>
      GetPrayerTimesOfMonthCubit.controller(context)
          .state
          .prayerTimesOfMonth
          .length -
      1;

  animateToNextPage() {
    pageController.nextPage(
        duration: AppDurations.lowDuration, curve: Curves.linear);
  }

  animateTopreviousPage() {
    pageController.previousPage(
        duration: AppDurations.lowDuration, curve: Curves.linear);
  }

  updateLocation(BuildContext context) async {
    loadUpdateLocationDialogNotifier.value = true;
    bool isLocationEnabled = await sl<BaseLocationService>().isServiceEnabled;
    bool isOnline = await sl<InternetConnection>().checkInternetConnection();
    showLocationUpdateDialog(
        context: context,
        isOnline: isOnline,
        isLocationEnabled: isLocationEnabledNotifier.value,
        onOpenInternet: () => sl<InternetConnection>().openInternetSettings(),
        onOpenLocation: () => sl<BaseLocationService>().openLocationSettings(),
        onUpdateLocation: () =>
            LocationCubit.controller(context).updateLocationRequest(context));
    loadUpdateLocationDialogNotifier.value = false;
  }
}
