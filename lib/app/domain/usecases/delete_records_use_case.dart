import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/app/domain/repositories/base_records_repo.dart';
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

class RecordsParameters extends Equatable {
  final int? id;
  final String? path;
  const RecordsParameters({required this.id, required this.path});
  @override
  List<Object?> get props => [id, path];
}
