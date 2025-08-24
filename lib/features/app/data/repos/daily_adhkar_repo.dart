import 'package:dartz/dartz.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/data/datasources/daily_adhkar_local_data_source.dart';
import 'package:test_app/features/app/domain/entities/daily_adhkar_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_daily_adhkar_repo.dart';

class DailyAdhkarRepo extends BaseDailyAdhkarRepo {
  DailyAdhkarRepo({required this.localDataSource});

  final BaseDailyAdhkarLocalDataSource localDataSource;

  @override
  Future<Either<Failure, Unit>> addDailyAdhkar(
      {required DailyAdhkarEntity entity}) async {
    try {
      await localDataSource.saveDailyAdhkar(entity);
      return const Right(unit);
    } catch (_) {
      return Left(Failure(AppStrings.translate("unExpectedError")));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteDailyAdhkar({required int index}) async {
    try {
      await localDataSource.deleteDailyAdhkar(index);
      return const Right(unit);
    } catch (_) {
      return Left(Failure(AppStrings.translate("unExpectedError")));
    }
  }

  @override
  Future<Either<Failure, List<DailyAdhkarEntity>>> getAllDailyAdhkar() async {
    try {
      return Right(await localDataSource.getAllDailyAdhkar());
    } catch (_) {
      return Left(Failure(AppStrings.translate("unExpectedError")));
    }
  }

  @override
  Future<Either<Failure, Unit>> markedAsSeen({required int index}) async {
    try {
      await localDataSource.markAsShown(index);
      return const Right(unit);
    } catch (_) {
      return Left(Failure(AppStrings.translate("unExpectedError")));
    }
  }
}
