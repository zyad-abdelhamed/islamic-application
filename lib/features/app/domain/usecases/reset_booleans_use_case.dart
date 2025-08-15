import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/domain/repositories/r_table_repo.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/base_use_case.dart';

class ResetBooleansUseCase
    extends BaseUseCaseWithoutParameters<Unit> {
  final BaseRTableRepo baseRTableRepo;
  ResetBooleansUseCase(this.baseRTableRepo);
  @override
  Future<Either<Failure, Unit>> call() async {
    return await baseRTableRepo.resetBooleans();
  }
}
