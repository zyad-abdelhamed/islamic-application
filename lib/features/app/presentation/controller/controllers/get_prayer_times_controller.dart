import 'package:flutter/material.dart';
import 'package:test_app/features/app/domain/entities/location_entity.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/domain/repositories/location_repo.dart';
import 'package:test_app/features/app/domain/usecases/get_prayers_times_use_case.dart';
import 'package:test_app/core/constants/routes_constants.dart';

class GetPrayersTimesController {
  GetPrayersTimesController({
    required this.getPrayersTimesUseCase,
    required this.baseLocationRepo,
  });

  final GetPrayersTimesUseCase getPrayersTimesUseCase;
  final BaseLocationRepo baseLocationRepo;

  Timings timings = Timings.empty();
  String? errorMessage;
  final ValueNotifier<bool> hasErrorNotifier = ValueNotifier(false);
  LocationEntity locationEntity =
      LocationEntity(latitude: 0.0, longitude: 0.0, name: '');

  Future<void> getPrayersTimes(BuildContext context) async {
    final result = await getPrayersTimesUseCase();

    await result.fold(
      (failure) {
        hasErrorNotifier.value = true;

        errorMessage = failure.message;

        _goToHomePage(context);
      },
      (prayerTimes) async {
        timings = prayerTimes;

        hasErrorNotifier.value = false;

        final locationResult = await baseLocationRepo.getCurrentLocation();

        locationResult.fold(
          (failure) => null,
          (location) => locationEntity = location,
        );

        _goToHomePage(context);
      },
    );
  }

  void _goToHomePage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesConstants.homePageRouteName,
      (route) => false,
    );
  }
}
