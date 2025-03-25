import 'package:dartz/dartz.dart';
import 'package:test_app/app/data/datasources/adhkar_local_data_source.dart';
import 'package:test_app/app/data/datasources/adhkar_remote_data_source.dart';
import 'package:test_app/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/app/domain/repositories/adhkar_repo.dart';
import 'package:test_app/core/errors/failures.dart';

class AdhkarRepo extends BaseAdhkarRepo {
  final AdhkarRemoteDataSource adhkarRemoteDataSource;
  final AdhkarLocalDataSource adhkarLocalDataSource;
  AdhkarRepo(this.adhkarRemoteDataSource, this.adhkarLocalDataSource);
  @override
  Future<Either<Failure, List<AdhkarEntity>>> getAdhkar(
      {required String nameOfAdhkar}) async {
    try {
      final cachedAdhkar = await adhkarLocalDataSource.getCachedAdhkar();

      if (cachedAdhkar.isNotEmpty) {
        return Right(cachedAdhkar);
      }

      final remoteAdhkar =
          await adhkarRemoteDataSource.getAdhkar(nameOfAdhkar: nameOfAdhkar);
      await adhkarLocalDataSource.cacheAdhkar(remoteAdhkar);
      return Right(remoteAdhkar);
    } catch (e) {
      return const Left(Failure('error'));
    }
  }
}
