import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/data/datasources/quran_local_data_source.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';
import 'package:test_app/core/errors/failures.dart';

class QuranRepo extends BaseQuranRepo {
  final QuranLocalDataSource quranLocalDataSource;
  QuranRepo({required this.quranLocalDataSource});
  @override
  Future<Either<Failure, List<SurahEntity>>> getPartSurahs(
      {required String part}) async {
    try {
      List<SurahEntity> result =
          await quranLocalDataSource.getInfoQuran(part: part);
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
