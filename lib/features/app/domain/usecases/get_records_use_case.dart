import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/domain/entities/featured_record_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_records_repo.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/base_use_case.dart';


class GetRecordsUseCase
    extends BaseUseCaseWithoutParameters<List<FeaturedRecordEntity>> {
  final BaseRecordsRepo baseRecordsRepo;

  GetRecordsUseCase({required this.baseRecordsRepo});
  @override
  Future<Either<Failure, List<FeaturedRecordEntity>>> call() async {
    return await baseRecordsRepo.getRecords();
  }
}
