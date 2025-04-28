import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:test_app/features/app/data/datasources/home_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/home_remote_data_source.dart';
import 'package:test_app/features/app/data/models/adhkar_parameters.dart';
import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/features/app/domain/entities/hadith.dart';
import 'package:test_app/features/app/domain/repositories/home_repo.dart';
import 'package:test_app/core/errors/failures.dart';

class HomeRepo extends BaseHomeRepo {
  final HomeLocalDataSource adhkarLocalDataSource;
  final BaseHomeRemoteDataSource baseHomeRemoteDataSource;
  HomeRepo(this.adhkarLocalDataSource, this.baseHomeRemoteDataSource);
  @override
  Future<Either<Failure, List<AdhkarEntity>>> getAdhkar(
      {required AdhkarParameters adhkarParameters}) async {
    try {
      return Right(await adhkarLocalDataSource.getAdhkar(adhkarParameters));
    } catch (e) {
      return const Left(
          Failure("خطأ أثناء جلب البيانات: تحقق من المدخلات أو مصدر البيانات"));
    }
  }

  @override
  Future<Either<Failure, Hadith>> getRandomHadith() async {
    try {
      Hadith ahadith = await baseHomeRemoteDataSource.getAhadiths();
      return right(ahadith);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
