import 'package:dartz/dartz.dart';
import 'package:test_app/app/domain/repositories/base_records_repo.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/base_use_case.dart';


class GetRecordsUseCase
    extends BaseUseCaseWithoutParameters<List<int>> {
  final BaseRecordsRepo baseRecordsRepo;

  GetRecordsUseCase({required this.baseRecordsRepo});
  @override
  Future<Either<Failure, List<int>>> call() async {
    return await baseRecordsRepo.getRecords();
  }
}
