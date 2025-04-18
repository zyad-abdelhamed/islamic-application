import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/data/datasources/records_local_data_source.dart';
import 'package:test_app/features/app/domain/repositories/base_records_repo.dart';
import 'package:test_app/features/app/domain/usecases/delete_records_use_case.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';

class RecordsRepo extends BaseRecordsRepo {
  final RecordsLocalDataSource recordsLocalDataSource;

  RecordsRepo({required this.recordsLocalDataSource});
  @override
  Future<Either<Failure, Unit>> addRecord(
      {required RecordsParameters parameters}) async {
    final int baseNumberOfRecords = 5;
    if (parameters.item! > baseNumberOfRecords) {
      try {
        await recordsLocalDataSource.addRecord(parameters: parameters);
        parameters.context!.elecRosaryController
            .resetCounter(); //reset elec rosary counter

        return const Right(unit);
      } catch (e) {
        return const Left(Failure('error in add'));
      }
    } else if (parameters.item! == 0) {
      return const Left(Failure('لا يمكن حفظ ريكورد خالي'));
    } else {
      return left(Failure('لا يمكن حفظ ريكورد أقل من $baseNumberOfRecords'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAllRecords() async {
    try {
      await recordsLocalDataSource.deleteAllRecords();
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
  Future<Either<Failure, List<int>>> getRecords() async {
    try {
      List<int> result = await recordsLocalDataSource.getRecords();
      return Right(result);
    } catch (e) {
      return const Left(Failure('error in getrecords'));
    }
  }
}
