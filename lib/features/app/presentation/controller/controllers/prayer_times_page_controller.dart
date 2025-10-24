import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/services/arabic_converter_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/internet_connection.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/data/models/get_prayer_times_of_month_prameters.dart';
import 'package:test_app/features/app/domain/entities/prayer_sound_settings_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/location_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_prayer_times_of_month_cubit.dart';
import 'package:test_app/core/widgets/custom_alert_dialog.dart';
import 'package:test_app/core/widgets/save_or_update_location_widget.dart';

class PrayerTimesPageController {
  late PageController pageController;
  late final ValueNotifier<bool> nextButtonVisibleNotifier;
  late final ValueNotifier<bool> previousButtonVisibleNotifier;
  late final ValueNotifier<DateTime> dateNotifier;
  late final ValueNotifier<bool> loadingNotifier;
  late final ValueNotifier<bool> isSwitchsShowedNotifier;
  late final ValueNotifier<PrayerSoundSettingsEntity?>
      prayerSoundSettingsEntityNotifier;

  late ValueNotifier<PrayerSoundSettingsEntity?> originalPrayerSoundSettings;

  Future<void> initState(BuildContext context) async {
    loadingNotifier = ValueNotifier<bool>(false);
    isSwitchsShowedNotifier = ValueNotifier<bool>(false);

    pageController = PageController(initialPage: DateTime.now().day - 1);
    dateNotifier = ValueNotifier<DateTime>(DateTime.now());
    previousButtonVisibleNotifier =
        ValueNotifier<bool>(_getPreviousButtonNotifierValue);
    nextButtonVisibleNotifier =
        ValueNotifier<bool>(_getNextButtonNotifierValue);
    prayerSoundSettingsEntityNotifier =
        ValueNotifier<PrayerSoundSettingsEntity?>(null);
    originalPrayerSoundSettings =
        ValueNotifier<PrayerSoundSettingsEntity?>(null);
  }

  // ----- دوال خاصة بإعدادات صوت الصلاة -----

  void initPrayerSettings(PrayerSoundSettingsEntity initialSettings) {
    originalPrayerSoundSettings.value = initialSettings;
    prayerSoundSettingsEntityNotifier.value = initialSettings;
  }

  void toggleIsSwitchsShowed() {
    isSwitchsShowedNotifier.value = !isSwitchsShowedNotifier.value;
  }

  bool get hasPrayerSoundChanges {
    final current = prayerSoundSettingsEntityNotifier.value;
    return current != null
        ? current != originalPrayerSoundSettings.value
        : false;
  }

  void updatePrayerSoundSetting(String prayerKey, bool value) {
    final current = prayerSoundSettingsEntityNotifier.value;
    if (current == null) return;
    prayerSoundSettingsEntityNotifier.value =
        current.copyWithPrayer(prayerKey, value);
  }

  void cancelPrayerSoundChanges() {
    prayerSoundSettingsEntityNotifier.value = originalPrayerSoundSettings.value;
  }

  PrayerSoundSettingsEntity? get currentSettings =>
      prayerSoundSettingsEntityNotifier.value;

  void markAsSaved() {
    if (prayerSoundSettingsEntityNotifier.value != null) {
      originalPrayerSoundSettings.value =
          prayerSoundSettingsEntityNotifier.value!;
    }
  }

  // ----- نهاية دوال إعدادات صوت الصلاة -----

  void dispose() {
    pageController.dispose();
    nextButtonVisibleNotifier.dispose();
    previousButtonVisibleNotifier.dispose();
    loadingNotifier.dispose();
    isSwitchsShowedNotifier.dispose();
    prayerSoundSettingsEntityNotifier.dispose();
    originalPrayerSoundSettings.dispose();
  }

  List<String> get dateData {
    return <String>[
      sl<BaseArabicConverterService>()
          .convertToArabicDigits(dateNotifier.value.day.toString())
          .toString(),
      sl<BaseArabicConverterService>()
          .convertToArabicDigits(dateNotifier.value.month.toString())
          .toString(),
      sl<BaseArabicConverterService>()
          .convertToArabicDigits(dateNotifier.value.year.toString())
          .toString()
    ];
  }

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
    pageController = PageController(initialPage: dateNotifier.value.day - 1);
    previousButtonVisibleNotifier.value = _getPreviousButtonNotifierValue;
    nextButtonVisibleNotifier.value = _getNextButtonNotifierValue;
    GetPrayerTimesOfMonthCubit.controller(context).getPrayerTimesOfMonth(
        GetPrayerTimesOfMonthPrameters(date: dateNotifier.value));
  }

  bool get _getNextButtonNotifierValue {
    final DateTime currentDate = dateNotifier.value;
    final int lastDayOfMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0).day;
    return currentDate.day < lastDayOfMonth;
  }

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

  void animateToNextPage() {
    pageController.nextPage(
        duration: AppDurations.lowDuration, curve: Curves.linear);
  }

  void animateTopreviousPage() {
    pageController.previousPage(
        duration: AppDurations.lowDuration, curve: Curves.linear);
  }

  Future<void> updateLocation(BuildContext context) async {
    loadingNotifier.value = true;
    final bool isConnected =
        await sl<InternetConnection>().checkInternetConnection();
    final bool isEnabled = await sl<BaseLocationService>().isServiceEnabled;

    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => sl<LocationCubit>(),
          child: CustomAlertDialog(
            title: 'تحديث الموقع',
            alertDialogContent: (context) => BlocProvider(
              create: (context) => sl<LocationCubit>(),
              child: SaveOrUpdateLocationWidget(
                functionaltiy: Functionaltiy.update,
                buttonName: 'تحديث الموقع',
                isConnected: isConnected,
                isLocationEnabled: isEnabled,
              ),
            ),
            iconWidget: (BuildContext context) => const Icon(
              Icons.location_on,
              color: AppColors.secondryColor,
            ),
          ),
        );
      },
    );
    loadingNotifier.value = false;
  }
}
