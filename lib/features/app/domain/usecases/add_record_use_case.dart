import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/domain/repositories/base_records_repo.dart';
import 'package:test_app/features/app/domain/usecases/delete_records_use_case.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/base_use_case.dart';

class AddRecordUseCase
    extends BaseUseCaseWithParameters<Unit, RecordsParameters> {
  final BaseRecordsRepo baseRecordsRepo;

  AddRecordUseCase({required this.baseRecordsRepo});
  @override
  Future<Either<Failure, Unit>> call({required parameters}) async {
    return await baseRecordsRepo.addRecord(parameters: parameters);
  }
}
