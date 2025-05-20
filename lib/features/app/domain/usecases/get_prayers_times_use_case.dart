import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/domain/repositories/base_prayer_repo.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/base_use_case.dart';


class GetPrayersTimesUseCase
    extends BaseUseCaseWithoutParameters<Timings> {
  final BasePrayerRepo basePrayerRepo;

  GetPrayersTimesUseCase({required this.basePrayerRepo});
  @override
  Future<Either<Failure, Timings>> call() async {
    return await basePrayerRepo.getPrayerTimes();
  }
}
