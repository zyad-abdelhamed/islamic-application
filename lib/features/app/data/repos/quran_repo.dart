import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/data/datasources/quran_local_data_source.dart';
import 'package:test_app/features/app/data/datasources/quran_remote_data_source.dart';
import 'package:test_app/features/app/data/models/tafsir_request_params.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';
import 'package:test_app/core/errors/failures.dart';

class QuranRepo implements BaseQuranRepo {
  final QuranLocalDataSource _quranLocalDataSource;
  final BaseQuranRemoteDataSource _baseQuranRemoteDataSource;

  QuranRepo(
    this._baseQuranRemoteDataSource,
    this._quranLocalDataSource,
  );

  @override
  Future<Either<Failure, List<SurahEntity>>> getPartSurahs(
      {required String part}) async {
    try {
      final List<SurahEntity> result =
          await _quranLocalDataSource.getInfoQuran(part: part);
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TafsirAyahEntity>>> getSurahWithTafsir(
      TafsirRequestParams params) async {
    try {
      final List<TafsirAyahEntity> result = await _baseQuranRemoteDataSource
          .getSurahWithTafsir(params);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
