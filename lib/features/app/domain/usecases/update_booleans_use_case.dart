import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/domain/repositories/r_table_repo.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/models/booleans_model.dart';
import 'package:test_app/core/utils/base_use_case.dart';

class UpdateBooleansUseCase
    extends BaseUseCaseWithParameters<Unit, BooleansParameters> {
  final BaseRTableRepo baseRTableRepo;
  UpdateBooleansUseCase(this.baseRTableRepo);
  @override
  Future<Either<Failure, Unit>> call(
      {required BooleansParameters parameters}) async {
    return await baseRTableRepo.updateBooleans(parameters: parameters);
  }
}
