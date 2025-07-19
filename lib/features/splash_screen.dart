import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/domain/usecases/get_prayers_times_use_case.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    sl<GetPrayersTimesController>().getPrayersTimes(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Image.asset(
          'assets/images/mosque (1).png',
          height: context.height * .5,
          width: context.width * .5,
        ),
      ),
    );
  }
}

class GetPrayersTimesController {
  late Timings timings;
  final GetPrayersTimesUseCase getPrayersTimesUseCase;
  GetPrayersTimesController({required this.getPrayersTimesUseCase});
  void getPrayersTimes(BuildContext context) async {
    // final PrayerTimesCubit prayerTimesCubit = sl<PrayerTimesCubit>();

    Either<Failure, Timings> result = await getPrayersTimesUseCase();
    result.fold(
      (l) {},
      (prayerTimes) {
        timings = prayerTimes;
        
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesConstants.homePageRouteName,
          (route) => false,
        );
      },
    );
  }
}
