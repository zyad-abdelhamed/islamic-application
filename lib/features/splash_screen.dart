import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/services/city_name_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/domain/usecases/get_prayers_times_use_case.dart';
import 'package:test_app/features/app/presentation/view/components/custom_alert_dialog.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final ValueNotifier<double> opacityNotifier = ValueNotifier<double>(0.0);

  void start(BuildContext context) {
    // نبدأ الأنميشن بعد لحظة بسيطة
    Future.delayed(const Duration(milliseconds: 300), () {
      opacityNotifier.value = 1.0;
    });

    // نستدعي API بتاعك عادي
    sl<GetPrayersTimesController>().getPrayersTimes(context);
  }

  @override
  Widget build(BuildContext context) {
    start(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: ValueListenableBuilder<double>(
          valueListenable: opacityNotifier,
          builder: (context, opacity, _) {
            return AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              child: Image.asset(
                'assets/images/mosque (1).png',
                height: context.height * 0.5,
                width: context.width * 0.5,
              ),
            );
          },
        ),
      ),
    );
  }
}


class GetPrayersTimesController {
  late Timings? timings;
  late String cityName;
  final GetPrayersTimesUseCase getPrayersTimesUseCase;
  GetPrayersTimesController({required this.getPrayersTimesUseCase});
  void getPrayersTimes(BuildContext context) async {
    Either<Failure, Timings> result = await getPrayersTimesUseCase();
    result.fold(
      (l) {
                timings = null;
               CustomAlertDialog(alertDialogContent: (context) => Text(l.message) ,title:'' ,);

      },
      (prayerTimes) async {
        timings = prayerTimes;
        cityName = await _getCityName();
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesConstants.homePageRouteName,
          (route) => false,
        );
      },
    );
  }

  Future<String> _getCityName() async {
    final LocationPermission permission =
        await sl<BaseLocationService>().checkPermission;
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      final Position position = await sl<BaseLocationService>().position;
      return await sl<LocationNameService>()
          .getCityNameFromCoordinates(position.altitude, position.longitude);
    }
    return 'القاهرة';
  }
}
