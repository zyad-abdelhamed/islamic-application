import 'package:dartz/dartz.dart';
import 'package:test_app/app/domain/entities/next_prayer_entity.dart';
import 'package:test_app/app/domain/repositories/base_prayer_repo.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/base_use_case.dart';

class GetNextPrayerUseCase
    extends BaseUseCaseWithoutParameters<NextPrayerEntity> {
  final BasePrayerRepo basePrayerRepo;

  GetNextPrayerUseCase({required this.basePrayerRepo});
  @override
  Future<Either<Failure, NextPrayerEntity>> call() async {
    return await basePrayerRepo.getNextPrayer();
  }
}
