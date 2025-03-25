import 'package:dartz/dartz.dart';
import 'package:test_app/app/data/datasources/records_local_data_source.dart';
import 'package:test_app/app/domain/repositories/base_records_repo.dart';
import 'package:test_app/app/domain/usecases/delete_records_use_case.dart';
import 'package:test_app/core/errors/failures.dart';

class RecordsRepo extends BaseRecordsRepo {
  final RecordsLocalDataSource recordsLocalDataSource;

  RecordsRepo({required this.recordsLocalDataSource});
  @override
  Future<Either<Failure, Unit>> addRecord(
      {required RecordsParameters parameters}) async {
    try {
      await recordsLocalDataSource.addRecord(parameters: parameters);
      return const Right(unit);
    } catch (e) {
      return const Left(Failure('error in add'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAllRecords(
      {required RecordsParameters parameters}) async {
    try {
      await recordsLocalDataSource.deleteAllRecords(parameters: parameters);
      return const Right(unit);
    } catch (e) {
      return const Left(Failure('error in deleteallrecords'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteRecord(
      {required RecordsParameters parameters}) async {
    try {
      await recordsLocalDataSource.deleteRecord(parameters: parameters);
      return const Right(unit);
    } catch (e) {
      return const Left(Failure('error in delete'));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getRecords(
      {required RecordsParameters parameters}) async {
    try {
      List<int> result =
          await recordsLocalDataSource.getRecords(parameters: parameters);
      return Right(result);
    } catch (e) {
      return const Left(Failure('error in getrecords'));
    }
  }
}
