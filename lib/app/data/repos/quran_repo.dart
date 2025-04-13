import 'package:dartz/dartz.dart';
import 'package:test_app/app/data/datasources/quran_local_data_source.dart';
import 'package:test_app/app/domain/entities/quran_entity.dart';
import 'package:test_app/app/domain/repositories/base_quran_repo.dart';
import 'package:test_app/core/errors/failures.dart';

class QuranRepo extends BaseQuranRepo {
  final QuranLocalDataSource quranLocalDataSource;
  QuranRepo({required this.quranLocalDataSource});
  @override
  Future<Either<Failure, List<QuranEntity>>> getInfoQuran(
      {required String part}) async {
    try {
      List<QuranEntity> result =
          await quranLocalDataSource.getInfoQuran(part: part);
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
