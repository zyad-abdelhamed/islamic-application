import 'package:dartz/dartz.dart';
import 'package:test_app/features/app/data/models/quran_audio_parameters.dart';
import 'package:test_app/features/app/data/repos/quran_repo.dart';
import 'package:test_app/features/app/domain/entities/ayah_entity.dart';
import 'package:test_app/features/app/domain/entities/ayah_search_result_entity.dart';
import 'package:test_app/features/app/domain/entities/book_mark_entity.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/domain/entities/surah_with_tafsir_entity.dart';

abstract class BaseQuranRepo {
  //   ===bookMarks methodes===
  Future<Either<Failure, Unit>> saveBookMark(
      {required BookMarkEntity bookmarkentity});
  Future<Either<Failure, Unit>> clearBookMarks();
  Future<Either<Failure, Unit>> deleteBookmarksList(
      {required List<int> indexs});
  Future<Either<Failure, List<BookMarkEntity>>> getBookMarks();
  //   ===surah with tafsir methodes===
  Future<Either<Failure, SearchAyahWithTafsirEntity>> search(String query);
  Future<Either<Failure, List<SurahEntity>>> getSurahsInfo();
  Future<Either<Failure, Unit>> downloadSurahWithTafsir({
    required TafsirRequestParams tafsirRequestParams,
    required SurahRequestParams surahRequestParams,
    required List<ReciterEntity> selectedReciters,
  });
  Future<Either<Failure, SurahWithTafsirEntity>> getSurahWithTafsir({
    required TafsirRequestParams tafsirRequestParams,
    required SurahRequestParams surahRequestParams,
  });
  Future<Either<Failure, List<AyahEntity>>> getSpecificAyahs(
      {required SurahRequestParams surahRequestParams});
  Future<Either<Failure, Unit>> deleteSurahWithTafsir({required String key});
  //   ===audio methodes===
  Future<Either<Failure, List<ReciterEntity>>> getReciters(
      {required String surahName});
  String getAyahAudioUrl(AyahAudioRequestParams params);
  Future<Either<Failure, SurahDownloadResult>> downloadSurahAudio(
      SurahAudioRequestParams params);
  Future<Either<Failure, Unit>> deleteSurahAudio(
      SurahAudioRequestParams params);
  Future<Either<Failure, SurahDownloadResult>> downloadFailedAyahsAudio(
      {required SurahAudioRequestParams params,
      required List<int> failedAyahs});
}
