import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/domain/entities/featured_record_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_records_repo.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/base_use_case.dart';

class DeleteRecordsUseCase
    extends BaseUseCaseWithParameters<Unit, RecordsParameters> {
  final BaseRecordsRepo baseRecordsRepo;

  DeleteRecordsUseCase(this.baseRecordsRepo);
  @override
  Future<Either<Failure, Unit>> call({required parameters}) async {
    return await baseRecordsRepo.deleteRecord(parameters: parameters);
  }
}

class RecordsParameters{
  final FeaturedRecordEntity? recordEntity;
  final int? index;
  const RecordsParameters({this.recordEntity, this.index});
}
