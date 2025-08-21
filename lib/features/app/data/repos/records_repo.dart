import 'package:dartz/dartz.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/data/datasources/records_local_data_source.dart';
import 'package:test_app/features/app/domain/entities/featured_record_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_records_repo.dart';
import 'package:test_app/features/app/domain/usecases/delete_records_use_case.dart';
import 'package:test_app/core/errors/failures.dart';

class RecordsRepo extends BaseRecordsRepo {
  final RecordsLocalDataSource recordsLocalDataSource;

  RecordsRepo({required this.recordsLocalDataSource});
  @override
  Future<Either<Failure, Unit>> addRecord(
      {required RecordsParameters parameters}) async {
    if (parameters.recordEntity!.value == 0) {
      return const Left(Failure("لا يمكن اضافة ريكورد فارغ"));
    }

    try {
      await recordsLocalDataSource.addRecord(parameters: parameters);
      return const Right(unit);
    } catch (_) {
      return Left(Failure(AppStrings.translate("unExpectedError")));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAllRecords() async {
    try {
      await recordsLocalDataSource.deleteAllRecords();
      return const Right(unit);
    } catch (_) {
      return Left(Failure(AppStrings.translate("unExpectedError")));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteRecord(
      {required RecordsParameters parameters}) async {
    try {
      await recordsLocalDataSource.deleteRecord(parameters: parameters);
      return const Right(unit);
    } catch (_) {
      return Left(Failure(AppStrings.translate("unExpectedError")));
    }
  }

  @override
  Future<Either<Failure, List<FeaturedRecordEntity>>> getRecords() async {
    try {
      List<FeaturedRecordEntity> result =
          await recordsLocalDataSource.getRecords();
      return Right(result);
    } catch (_) {
      return Left(Failure(AppStrings.translate("unExpectedError")));
    }
  }
}
