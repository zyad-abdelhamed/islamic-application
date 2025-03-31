import 'package:dartz/dartz.dart';
import 'package:test_app/app/domain/repositories/base_records_repo.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/base_use_case.dart';

class DeleteAllRecordsUseCase extends BaseUseCaseWithoutParameters<Unit> {
  final BaseRecordsRepo baseRecordsRepo;

  DeleteAllRecordsUseCase({required this.baseRecordsRepo});
  @override
  Future<Either<Failure, Unit>> call() async {
    return await baseRecordsRepo.deleteAllRecords();
  }
}
