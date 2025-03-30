import 'package:dartz/dartz.dart';
import 'package:test_app/app/data/datasources/home_local_data_source.dart';
import 'package:test_app/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/app/domain/repositories/home_repo.dart';
import 'package:test_app/app/domain/usecases/get_adhkar_use_case.dart';
import 'package:test_app/core/errors/failures.dart';

class HomeRepo extends BaseHomeRepo {
  final HomeLocalDataSource adhkarLocalDataSource;
  HomeRepo(this.adhkarLocalDataSource);
  @override
  Future<Either<Failure, List<AdhkarEntity>>> getAdhkar(
      {required AdhkarParameters adhkarParameters}) async {
    try {
      return Right(await adhkarLocalDataSource.getAdhkar(adhkarParameters));
    } catch (e) {
      return const Left(Failure("خطأ أثناء جلب البيانات: تحقق من المدخلات أو مصدر البيانات"));
    }
  }
}
