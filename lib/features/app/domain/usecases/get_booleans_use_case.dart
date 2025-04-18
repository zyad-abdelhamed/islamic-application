import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/domain/repositories/r_table_repo.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/base_use_case.dart';

class GetBooleansUseCase extends BaseUseCaseWithoutParameters<List<bool>> {
  final BaseRTableRepo repo;
  GetBooleansUseCase(this.repo);
  @override
  Future<Either<Failure, List<bool>>> call() async {
    return await repo.getBooleans();
  }
}
