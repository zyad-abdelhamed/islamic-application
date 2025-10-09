import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/constants/cache_constants.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/services/cache_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/app/domain/entities/location_entity.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/domain/repositories/location_repo.dart';
import 'package:test_app/features/app/domain/usecases/get_prayers_times_use_case.dart';

class GetPrayersTimesController {
  GetPrayersTimesController({
    required this.getPrayersTimesUseCase,
    required this.baseLocationRepo,
  });

  final GetPrayersTimesUseCase getPrayersTimesUseCase;
  final BaseLocationRepo baseLocationRepo;
  final BaseCacheService cache = sl<BaseCacheService>();

  Timings timings = Timings.empty();
  LocationEntity? locationEntity;

  Future<void> getPrayersTimes({VoidCallback? onTerminated}) async {
    final Either<Failure, Timings> result = await getPrayersTimesUseCase();

    await result.fold(
      (failure) {
        cache.insertStringToCache(
            key: CacheConstants.getPrayersTimesErrorMessage,
            value: failure.message);

        onTerminated?.call();
      },
      (prayerTimes) async {
        cache.insertStringToCache(
            key: CacheConstants.getPrayersTimesErrorMessage, value: '');

        timings = prayerTimes;

        final Either<Failure, LocationEntity> locationResult =
            await baseLocationRepo.getCurrentLocation();

        locationResult.fold(
          (failure) => null,
          (location) => locationEntity = location,
        );

        onTerminated?.call();
      },
    );
  }
}
