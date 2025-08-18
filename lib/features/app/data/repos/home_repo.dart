import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:test_app/features/app/data/datasources/home_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/home_remote_data_source.dart';
import 'package:test_app/features/app/data/models/adhkar_parameters.dart';
import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/features/app/domain/entities/duaa_entity.dart';
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
  Future<Either<Unit, Hadith>> getRandomHadith() async {
    try {
      final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final String lastDate = homeLocalDataSource.getLastHadithDate() ?? "";

      if (lastDate == today) {
        // يعني المستخدم فتح النهاردة قبل كده → ما نجيبش حديث جديد
        return const Left(unit);
      }

      final hadith = await homeLocalDataSource.getAhadiths();
      await homeLocalDataSource.cacheTodayHadithDate(today);
      return Right(hadith);
    } catch (_) {
      return const Left(unit);
    }
  }

   @override
  Future<Either<Failure, List<DuaaEntity>>> getDuaaWithPegnation() async {
    try {
      return Right(await homeLocalDataSource.getDuaas());
    } catch (e) {
      return Left(Failure('خطاء في جلب الدعاء'));
    }
  }
}
