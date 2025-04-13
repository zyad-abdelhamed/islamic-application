import 'package:dartz/dartz.dart';
import 'package:test_app/app/domain/usecases/delete_records_use_case.dart';
import 'package:test_app/core/errors/failures.dart';

abstract class BaseRecordsRepo {
  Future<Either<Failure, Unit>> deleteRecord(
      {required RecordsParameters parameters});
  Future<Either<Failure, Unit>> addRecord(
      {required RecordsParameters parameters});
  Future<Either<Failure, Unit>> deleteAllRecords();
  Future<Either<Failure, List<int>>> getRecords();
}
