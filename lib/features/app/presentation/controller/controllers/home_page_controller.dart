import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
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
import 'package:test_app/features/app/presentation/controller/cubit/prayer_times_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/presentation/view/components/custom_alert_dialog.dart';

bool _isShowed = false;

class HomePageController {
  void initState(BuildContext context) {
    if (_isShowed == false) {
      checkLocationPermission(context);
      checkInternetConnection(context);
      loadTodayHadith(context);
      _isShowed = true;
    }

    // تهيئة PrayerTimesCubit
    if (sl<GetPrayersTimesController>().hasErrorNotifier.value == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<PrayerTimesCubit>().init(
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
        permission == LocationPermission.deniedForever) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
          AppSnackBar(
            message: 'تم رفض صلاحية الموقع.',
            label: 'صلاحية الموقع',
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
