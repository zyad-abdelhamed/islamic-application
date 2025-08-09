import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/data/datasources/home_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/home_remote_data_source.dart';
import 'package:test_app/features/app/data/models/adhkar_parameters.dart';
import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/features/app/domain/entities/hadith.dart';
import 'package:test_app/features/app/domain/repositories/home_repo.dart';
import 'package:test_app/core/errors/failures.dart';

class HomeRepo extends BaseHomeRepo {
  final HomeLocalDataSource homeLocalDataSource;
  final BaseHomeRemoteDataSource baseHomeRemoteDataSource;
  HomeRepo(this.homeLocalDataSource, this.baseHomeRemoteDataSource);
  @override
  Future<Either<Failure, List<AdhkarEntity>>> getAdhkar(
      {required AdhkarParameters adhkarParameters}) async {
    try {
      return Right(await homeLocalDataSource.getAdhkar(adhkarParameters));
    } catch (e) {
      return const Left(Failure("خطأ أثناء جلب البيانات"));
    }
  }

  @override
  Future<Either<Failure, Hadith>> getRandomHadith() async {
    try {
      Hadith ahadith = await homeLocalDataSource.getAhadiths();
      return right(ahadith);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
