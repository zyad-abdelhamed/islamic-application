import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/data/models/adhkar_parameters.dart';
import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/features/app/domain/repositories/home_repo.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/base_use_case.dart';

class GetAdhkarUseCase
    extends BaseUseCaseWithParameters<List<AdhkarEntity>, AdhkarParameters> {
  final BaseHomeRepo baseHomeRepo;
  GetAdhkarUseCase(this.baseHomeRepo);
  @override
  Future<Either<Failure, List<AdhkarEntity>>> call(
      {required AdhkarParameters parameters}) async {
    return await baseHomeRepo.getAdhkar(adhkarParameters: parameters);
  }
}