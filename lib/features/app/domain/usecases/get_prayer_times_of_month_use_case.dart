import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/data/models/get_prayer_times_of_month_prameters.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/domain/repositories/base_prayer_repo.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/base_use_case.dart';


class GetPrayerTimesOfMonthUseCase
    extends BaseUseCaseWithParameters<List<Timings>, GetPrayerTimesOfMonthPrameters> {
  final BasePrayerRepo basePrayerRepo;

  GetPrayerTimesOfMonthUseCase({required this.basePrayerRepo});
  @override
  Future<Either<Failure, List<Timings>>> call({required GetPrayerTimesOfMonthPrameters parameters}) async {
    return await basePrayerRepo.getPrayerTimesOfMonth(parameters);
  }
}
