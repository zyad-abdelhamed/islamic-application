import 'package:dartz/dartz.dart';
import 'package:test_app/app/domain/entities/timings.dart';
import 'package:test_app/app/domain/repositories/base_prayer_repo.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/base_use_case.dart';


class GetPrayersTimesUseCase
    extends BaseUseCaseWithParameters<Timings, TimingsParameters> {
  BasePrayerRepo basePrayerRepo;

  GetPrayersTimesUseCase({required this.basePrayerRepo});
  @override
  Future<Either<Failure, Timings>> call({required parameters}) async {
    return await basePrayerRepo.getPrayerTimes(parameters: parameters);
  }
}

class TimingsParameters {
  final String latitude;
  final String longitude;

  TimingsParameters({required this.latitude, required this.longitude});
}
