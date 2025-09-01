import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/constants/cache_constants.dart';
import 'package:test_app/core/services/cache_service.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/core/services/internet_connection.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/app/domain/repositories/home_repo.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_prayer_times_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/daily_adhkar_cubit.dart';
import 'package:test_app/features/app/presentation/controller/controllers/next_prayer_controller.dart';
import 'package:test_app/features/app/presentation/view/components/custom_alert_dialog.dart';

bool _isShowed = false;

class HomePageController {
  final BaseCacheService cache = sl<BaseCacheService>();
  void initState(BuildContext context,
      {required NextPrayerController nextPrayerController}) {
    if (_isShowed == false) {
      checkLocationPermission(context);
      checkInternetConnection(context);
      loadTodayHadith(context);
      _isShowed = true;
    }

    // تهيئة DailyAdhkarCubit
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DailyAdhkarCubit.get(context).getAllDailyAdhkar();
    });

    final String? errorMessage = cache.getStringFromCache(
        key: CacheConstants.getPrayersTimesErrorMessage);
    if (errorMessage != null && errorMessage.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        nextPrayerController.init(
          timings: sl<GetPrayersTimesController>().timings,
          context: context,
        );
      });
    }
  }

  void checkLocationPermission(BuildContext context) async {
    LocationPermission permission =
        await sl<BaseLocationService>().checkPermission;

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        (permission == LocationPermission.unableToDetermine &&
            sl<GetPrayersTimesController>().locationEntity == null)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppSnackBar(
          message: 'تم رفض صلاحية الموقع.',
          label: 'طلب الصلاحية',
          onPressed: () => Navigator.pushNamedAndRemoveUntil(context,
              RoutesConstants.locationPermissionPage, (route) => false),
          type: AppSnackBarType.error,
        ).show(context);
      });
      return;
    }

    if ((permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always) &&
        sl<GetPrayersTimesController>().locationEntity == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppSnackBar(
          message: 'لم يتم تحديد الموقع.',
          label: 'حفظ الموقع',
          onPressed: () => Navigator.pushNamedAndRemoveUntil(context,
              RoutesConstants.locationPermissionPage, (route) => false),
          type: AppSnackBarType.error,
        ).show(context);
      });
    }
  }

  void checkInternetConnection(BuildContext context) async {
    final connected = await sl<InternetConnection>().checkInternetConnection();
    // إذا لم يكن متصلًا
    if (!connected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppSnackBar(
          message: AppStrings.translate("noInternetConnection"),
          type: AppSnackBarType.info,
        ).show(context);
      });
    }
  }

  void loadTodayHadith(BuildContext context) async {
    final result = await sl<BaseHomeRepo>().getRandomHadith();
    result.fold(
      (failure) => null,
      (hadith) => showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          alertDialogContent: (context) => SingleChildScrollView(
            child: Text(
              hadith.content,
              style: TextStyles.bold20(context),
            ),
          ),
          title: 'حديث اليوم',
          iconWidget: (BuildContext context) => Icon(
            Icons.auto_stories_rounded,
            size: 32,
            color: AppColors.secondryColor,
          ),
        ),
      ),
    );
  }
}
