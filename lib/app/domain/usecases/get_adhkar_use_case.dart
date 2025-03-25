import 'package:dartz/dartz.dart';
import 'package:test_app/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/app/domain/repositories/adhkar_repo.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/base_use_case.dart';

class GetAdhkarUseCase
    extends BaseUseCaseWithParameters<List<AdhkarEntity>, String> {
  final BaseAdhkarRepo baseAdhkarRepo;
  GetAdhkarUseCase(this.baseAdhkarRepo);
  @override
  Future<Either<Failure, List<AdhkarEntity>>> call(
      {required String parameters}) async {
    return await baseAdhkarRepo.getAdhkar(nameOfAdhkar: parameters);
  }
}
