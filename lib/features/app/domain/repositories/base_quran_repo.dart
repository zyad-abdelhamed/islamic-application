import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/domain/entities/book_mark_entity.dart';
import 'package:test_app/features/app/data/models/tafsir_request_params.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';

  Future<Either<Failure, List<SurahEntity>>> getPartSurahs(
      {required String part});
  Future<Either<Failure, Unit>> saveBookMark(
      {required BookMarkEntity bookmarkentity});
  Future<Either<Failure, List<TafsirAyahEntity>>> getSurahWithTafsir(TafsirRequestParams params);
