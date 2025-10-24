import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/constants/cache_constants.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/services/cache_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';

class OnBoardingController {
  final BaseCacheService _cacheService = sl<BaseCacheService>();

  final int featuresNumber = AppStrings.translate("features").length;

  // Load state from SharedPreferences
  bool get loadState {
    return _cacheService.getboolFromCache(key: CacheConstants.isDisplayed) ??
        false;
  }

  // Mark onboarding as displayed
  Future<void> markAsDisplayed() async {
    // await NotificationsBackgroundTasksRepoImpl
    //     .registerDailyAdhkarNotificationsTask();
    await _cacheService.insertBoolToCache(
        key: CacheConstants.isDisplayed, value: true);
  }

  // Navigate to next page
  void toNextPage({
    required BuildContext context,
    required PageController controller,
  }) {
    if (!controller.hasClients) return;

    final int page = controller.page?.round() ?? 0;

    if (page == featuresNumber - 1) {
      goToLocationPermissionPage(context: context);
      return;
    }

    controller.jumpToPage(page + 1);
  }

  // Navigate to home
  void goToLocationPermissionPage({required BuildContext context}) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesConstants.locationPermissionPage,
      (route) => false,
    );
  }
}
