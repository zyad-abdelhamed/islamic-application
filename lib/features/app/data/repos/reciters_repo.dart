import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/data/datasources/reciters_local_data_source.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_reciters_repo.dart';

class RecitersRepo extends BaseRecitersRepo {
  final RecitersLocalDataSource recitersLocalDataSource;

  RecitersRepo({required this.recitersLocalDataSource});
  @override
  Future<Either<Failure, List<ReciterEntity>>> getReciters() async {
    try {
      final result = await recitersLocalDataSource.getReciters();
      return right(result);
    } catch (_) {
      return left(Failure('Unexpected Error'));
    }
  }
}
