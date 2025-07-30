import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/duaa/data/dataSource/duaa_local_data_source.dart';
import 'package:test_app/features/duaa/domain/entities/duaa_entity.dart';
import 'package:test_app/features/duaa/domain/repos/duaa_base_repo.dart';

class DuaaRepo extends DuaaBaseRepo {
  final DuaaLocalDataSource localDataSource;
  DuaaRepo(this.localDataSource);
  @override
  Future<Either<Failure, List<DuaaEntity>>> getDuaaWithPegnation() async {
    try {
      return Right(await localDataSource.getDuaaWithPegnation());
    } catch (e) {
      return Left(Failure('خطاء في جلب الدعاء'));
    }
  }
}
