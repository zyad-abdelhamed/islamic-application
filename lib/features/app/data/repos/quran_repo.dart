import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/download_service.dart';
import 'package:test_app/core/services/file_storage_service.dart';
import 'package:test_app/features/app/data/datasources/quran_local_data_source.dart';
import 'package:test_app/features/app/data/models/quran_audio_parameters.dart';
import 'package:test_app/features/app/domain/entities/ayah_audio_entity.dart';
import 'package:test_app/features/app/domain/entities/ayah_search_result_entity.dart';
import 'package:test_app/features/app/domain/entities/book_mark_entity.dart';
import 'package:test_app/features/app/data/datasources/quran_remote_data_source.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';
import 'package:test_app/features/app/domain/entities/hifz_plan_entity.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/domain/entities/ayah_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_prograss_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_with_tafsir_entity.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/helper_function/get_from_json.dart';
import 'package:test_app/features/app/data/models/tafsir_edition_model.dart';
import 'package:test_app/features/app/domain/entities/tafsir_edition_entity.dart';

class QuranRepo implements BaseQuranRepo {
  final QuranLocalDataSource _quranLocalDataSource;
  final BaseQuranRemoteDataSource _baseQuranRemoteDataSource;
  final QuranLocalDataSource quranLocalDataSource;
  final IFileStorageService _fileStorageService;
  final IDownloadService _downloadService;

  QuranRepo(
    this._baseQuranRemoteDataSource,
    this._quranLocalDataSource,
    this.quranLocalDataSource,
    this._fileStorageService,
    this._downloadService,
  );

  //   ===================== BookMarks =======================
  @override
  Future<Either<Failure, List<BookMarkEntity>>> getBookMarks() async {
    try {
      final result = await quranLocalDataSource.getBookMarks();
      return right(result);
    } catch (e) {
      return left(Failure('خطأ فى تحميل العلامات'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveBookMark(
      {required BookMarkEntity bookmarkentity}) async {
    try {
      await quranLocalDataSource.saveBookMark(bookmarkentity: bookmarkentity);
      return right(unit);
    } catch (e) {
      return left(Failure('خطأ ف حفظ العلامة'));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearBookMarks() async {
    try {
      await quranLocalDataSource.clearBookMarks();
      return right(unit);
    } catch (e) {
      return left(Failure('خطأ ف مسح العلامات'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteBookmarksList(
      {required List<int> indexs}) async {
    try {
      await quranLocalDataSource.deleteBookmarksList(indexes: indexs);
      return right(unit);
    } catch (e) {
      return left(Failure('خطأ في مسح العلامة'));
    }
  }

  //   ===================== SurahWithTafsir =======================
  @override
  Future<Either<Failure, SurahWithTafsirEntity>> getSurahWithTafsir(
      {required TafsirRequestParams tafsirRequestParams,
      required SurahRequestParams surahRequestParams}) async {
    try {
      final SurahWithTafsirEntity? cachedSurahWithTafsir =
          await _quranLocalDataSource.getSurahWithTafsir(
              key: tafsirRequestParams.surah.name);

      if (cachedSurahWithTafsir != null) {
        return Right(cachedSurahWithTafsir);
      }

      final SurahWithTafsirEntity remoteSurahWithTafsir =
          await _getSurahWithTafsirFromRemoteDataSoruce(
              tafsirRequestParams, surahRequestParams);
      return Right(remoteSurahWithTafsir);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return Left(ServerFailure(AppStrings.translate(e.toString())));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteSurahWithTafsir(
      {required String key}) async {
    try {
      await _quranLocalDataSource.deleteSurahWithTafsir(key: key);
      return right(unit);
    } catch (_) {
      return left(Failure(AppStrings.translate("unExpectedError")));
    }
  }

  @override
  Future<Either<Failure, Unit>> downloadSurahWithTafsir({
    required TafsirRequestParams tafsirRequestParams,
    required SurahRequestParams surahRequestParams,
    required List<ReciterEntity> selectedReciters,
  }) async {
    try {
      final SurahWithTafsirEntity remoteSurahWithTafsir =
          await _getSurahWithTafsirFromRemoteDataSoruce(
              tafsirRequestParams, surahRequestParams);
      await _quranLocalDataSource.saveSurahWithTafsir(
          surah: remoteSurahWithTafsir, key: tafsirRequestParams.surah.name);

      for (ReciterEntity reciter in selectedReciters) {
        await downloadSurahAudio(SurahAudioRequestParams(
          reciterId: reciter.identifier,
          reciterName: reciter.name,
          surahNumber: surahRequestParams.surahNumber,
          surahName: surahRequestParams.surah.name,
        ));
      }

      return right(unit);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return Left(ServerFailure(AppStrings.translate(e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<AyahEntity>>> getSpecificAyahs(
      {required SurahRequestParams surahRequestParams}) async {
    try {
      final List<AyahEntity> ayahs;
      final SurahWithTafsirEntity? cachedSurahWithTafsir =
          await _quranLocalDataSource.getSurahWithTafsir(
              key: surahRequestParams.surah.name);

      if (cachedSurahWithTafsir != null) {
        final int start = surahRequestParams.offset;
        final int end = start + surahRequestParams.limit;
        ayahs = cachedSurahWithTafsir.ayahsList.sublist(start, end);

        return Right(ayahs);
      }

      ayahs = await _baseQuranRemoteDataSource.getAyahs(surahRequestParams);

      return Right(ayahs);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }

      return Left(ServerFailure(AppStrings.translate("unExpectedError")));
    }
  }

  @override
  Future<Either<Failure, List<SurahEntity>>> getSurahsInfo() async {
    try {
      final List<SurahEntity> surahsInfo =
          await _quranLocalDataSource.getSurahsInfo();
      return right(surahsInfo);
    } catch (_) {
      return left(Failure(AppStrings.translate("unExpectedError")));
    }
  }

  @override
  Future<Either<Failure, SearchAyahWithTafsirEntity>> search(
    String query,
  ) async {
    try {
      // 1) Call remote data source للبحث عن الآيات
      final AyahSearchResultEntity searchResult =
          await _baseQuranRemoteDataSource.searchInQuran(query);

      if (searchResult.count == 0) {
        return left(Failure("لا يوجد نتائج للبحث"));
      }

      // 2) Load tafsir editions
      final List<TafsirEditionEntity> tafsirEditions =
          await loadTafsirEditions();

      // 3) جهز كل الريكوستات (ayah tafsir لكل edition) مع retry
      final List<Future<TafsirAyahEntity>> allRequests = [];

      for (final ayah in searchResult.ayahs) {
        for (final edition in tafsirEditions) {
          allRequests.add(
            _safeGetAyahTafsir(
              ayah.number,
              edition.identifier,
            ),
          );
        }
      }

      List<TafsirAyahEntity> responses;

      try {
        // 4) جرّب كلهم مرّة واحدة
        responses = await Future.wait(allRequests);
        print("✅ responses length: ${responses.length}");
      } on DioException catch (e) {
        // لو حصل overload أو rate-limit (مثلاً 429 أو 503)
        if (e.response?.statusCode == 429 || e.response?.statusCode == 503) {
          responses = await _runInBatches(allRequests, batchSize: 20);
        } else {
          return Left(ServerFailure.fromDiorError(e));
        }
      }

      // 5) رتب الناتج النهائي: لكل مفسر → List<TafsirAyahEntity>
      final Map<String, List<TafsirAyahEntity>> ayahsAllTafsir = {};

      for (int i = 0; i < searchResult.ayahs.length; i++) {
        for (int j = 0; j < tafsirEditions.length; j++) {
          final edition = tafsirEditions[j];
          final index = i * tafsirEditions.length + j;

          final TafsirAyahEntity tafsirEntity = responses[index];

          ayahsAllTafsir.putIfAbsent(edition.name, () => []);
          ayahsAllTafsir[edition.name]!.add(tafsirEntity);
        }
      }

      // 6) بناء الـ Entity النهائي
      final SearchAyahWithTafsirEntity entity = SearchAyahWithTafsirEntity(
        ayahsAllTafsir: ayahsAllTafsir,
        ayahSearchResultEntity: searchResult,
      );

      return right(entity);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDiorError(e));
      }
      print("❌ Unhandled error: $e");
      return Left(Failure(e.toString()));
    }
  }

  // helper functions for surah with tafsir
  Future<SurahWithTafsirEntity> _getSurahWithTafsirFromRemoteDataSoruce(
    TafsirRequestParams tafsirRequestParams,
    SurahRequestParams surahRequestParams,
  ) async {
    final List<TafsirEditionEntity> tafsirEditions = await loadTafsirEditions();

    final List data = await Future.wait([
      _baseQuranRemoteDataSource.getAyahs(surahRequestParams),
      ...List.generate(
        tafsirEditions.length,
        (i) => _baseQuranRemoteDataSource.getTafsirAyahs(
          tafsirRequestParams.copyWith(
            edition: tafsirEditions[i].identifier,
          ),
        ),
      ),
    ]);

// الآيات
    final List<AyahEntity> ayahsList = data[0] as List<AyahEntity>;

// باقي العناصر = تفاسير كل Edition بالترتيب
    final tafsirResults = data.sublist(1);

// بناء الـ Map: name → List<TafsirAyahEntity>
    final Map<String, List<TafsirAyahEntity>> allTafsir = {};

    for (int i = 0; i < tafsirEditions.length; i++) {
      final edition = tafsirEditions[i];
      final tafsirAyahs = tafsirResults[i] as List<TafsirAyahEntity>;

      allTafsir[edition.name] = tafsirAyahs;
    }

// الناتج النهائي
    final SurahWithTafsirEntity surahWithTafsir = SurahWithTafsirEntity(
      ayahsList: ayahsList,
      allTafsir: allTafsir,
    );

    return surahWithTafsir;
  }

  /// Safe tafsir fetch with retry + fallback
  Future<TafsirAyahEntity> _safeGetAyahTafsir(
    int ayahNumber,
    String edition, {
    int retries = 3,
  }) async {
    int attempt = 0;

    while (attempt < retries) {
      try {
        final tafsir = await _baseQuranRemoteDataSource.getAyahTafsir(
          ayahNumber,
          edition,
        );
        return tafsir;
      } catch (e) {
        attempt++;
        print(
            "⚠️ Attempt $attempt failed for ayah=$ayahNumber, edition=$edition, error=$e");

        if (attempt >= retries) {
          return const TafsirAyahEntity(
            text: "لا يوجد تفسير متاح لهذه الآية",
          );
        }

        // delay قبل المحاولة التالية
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }

    return const TafsirAyahEntity(
      text: "لا يوجد تفسير متاح لهذه الآية",
    );
  }

  Future<List<TafsirEditionEntity>> loadTafsirEditions() async {
    final List data = await getJson(RoutesConstants.tafsirJsonRouteName);

    return data.map((map) => TafsirEditionModel.fromJson(map)).toList();
  }

  Future<List<TafsirAyahEntity>> _runInBatches(
    List<Future<TafsirAyahEntity>> requests, {
    int batchSize = 20,
  }) async {
    final List<TafsirAyahEntity> results = [];

    for (var i = 0; i < requests.length; i += batchSize) {
      final batch = requests.skip(i).take(batchSize);
      final batchResults = await Future.wait(batch);
      results.addAll(batchResults as Iterable<TafsirAyahEntity>);
    }

    return results;
  }

  //   =====audio=====
  @override
  Future<Either<Failure, List<ReciterEntity>>> getReciters(
      {required String surahName}) async {
    try {
      final result =
          await _quranLocalDataSource.getReciters(surahName: surahName);
      return right(result);
    } catch (_) {
      return left(Failure(AppStrings.translate("unExpectedError")));
    }
  }

  @override
  String getAyahAudioUrl(AyahAudioRequestParams params) {
    return _baseQuranRemoteDataSource.getAyahAudioUrl(params);
  }

  @override
  Future<Either<Failure, SurahDownloadResult>> downloadSurahAudio(
      SurahAudioRequestParams params) async {
    try {
      // جلب الصوتيات من المصدر البعيد
      final List<AyahAudioEntity> ayahs =
          await _baseQuranRemoteDataSource.getSurahAudio(params);

      final String folderName = _getFolderName(params);

      // إنشاء المجلد (بدون حذف مسبق)
      await _fileStorageService.createFolder(folderName: folderName);

      final List<int> failedAyahs = [];

      await downloadAyahsInBatches(
        ayahs: ayahs,
        folderName: folderName,
        failedAyahs: failedAyahs,
      );

      // حفظ حالة التحميل في Hive
      await _quranLocalDataSource.markSurahAudioAsDownloaded(
        edition: params.reciterName,
        surahName: params.surahName,
        isComplete: failedAyahs.isEmpty,
        failedAyahs: failedAyahs,
      );

      // بناء نتيجة التحميل
      final result = SurahDownloadResult(
        success: failedAyahs.isEmpty,
        failedAyahs: failedAyahs,
      );

      return Right(result);
    } catch (e) {
      return Left(Failure("فشل تحميل السورة: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteSurahAudio(
      SurahAudioRequestParams params) async {
    try {
      final String folderName = _getFolderName(params);
      await _fileStorageService.deleteFolder(folderName: folderName);
      await _quranLocalDataSource.unmarkSurahAudioDownloaded(
        edition: params.reciterName,
        surahName: params.surahName,
      );
      return Right(unit);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SurahDownloadResult>> downloadFailedAyahsAudio(
      {required SurahAudioRequestParams params,
      required List<int> failedAyahs}) async {
    try {
      // جلب الصوتيات من المصدر البعيد
      final List<AyahAudioEntity> ayahs =
          await _baseQuranRemoteDataSource.getSurahAudio(params);

      final String folderName = _getFolderName(params);

      final List<int> newFailedAyahs = [];

      // فلترة الآيات المطلوبة فقط
      final List<AyahAudioEntity> targetAyahs = ayahs
          .where((ayah) => failedAyahs.contains(ayah.numberInSurah))
          .toList();

      await downloadAyahsInBatches(
        ayahs: targetAyahs,
        folderName: folderName,
        failedAyahs: newFailedAyahs,
      );

      // تحديث حالة التحميل في Hive
      await _quranLocalDataSource.markSurahAudioAsDownloaded(
        edition: params.reciterName,
        surahName: params.surahName,
        isComplete: failedAyahs.isEmpty,
        failedAyahs: failedAyahs,
      );

      // بناء نتيجة التحميل
      final result = SurahDownloadResult(
        success: failedAyahs.isEmpty,
        failedAyahs: failedAyahs,
      );

      return Right(result);
    } catch (e) {
      return Left(Failure("فشل تحميل الآيات: ${e.toString()}"));
    }
  }

//   ===helper functions for download surah audio===

// تحديد اسم المجلد بناءً على القارئ والسورة
  String _getFolderName(SurahAudioRequestParams params) {
    final String folderName = "${params.reciterName}_${params.surahName}";
    return folderName;
  }

// دالة لاختيار أول رابط صوتي صالح من القائمة
  String? _getValidAudioUrl(AyahAudioEntity ayah) {
    final List<String> allUrls = [
      if (ayah.audioUrl.isNotEmpty) ayah.audioUrl,
      ...ayah.audioSecondary.where((url) => url.isNotEmpty),
    ];
    for (final url in allUrls) {
      return url;
    }
    return null;
  }

  // تحميل آية واحدة مع إعادة المحاولة 3 مرات
  Future<void> _downloadSingleAyah(
      {required AyahAudioEntity ayah,
      required String folderName,
      required List<int> failedAyahs}) async {
    final String? url = _getValidAudioUrl(ayah);

    if (url == null) {
      failedAyahs.add(ayah.numberInSurah);
      return;
    }

    final File file = await _fileStorageService.getFile(
      folderName: folderName,
      fileName: ayah.numberInSurah.toString(),
      extension: "mp3",
    );

    int attempts = 0;
    while (attempts < 3) {
      try {
        await _downloadService.downloadToFile(url: url, targetFile: file);
        return;
      } catch (e) {
        if (e is FileSystemException &&
            e.osError?.message.toLowerCase().contains("space") == true) {
          await _fileStorageService.deleteFolder(folderName: folderName);
          throw Exception(
            "فشل تحميل الآية بسبب عدم وجود مساحة كافية على الجهاز. يرجى تحرير بعض المساحة وإعادة المحاولة.",
          );
        }

        attempts++;
        if (attempts >= 3) {
          failedAyahs.add(ayah.numberInSurah);
        } else {
          await Future.delayed(const Duration(seconds: 1));
        }
      }
    }
  }

  // تحديد حجم الدفعة حسب عدد الآيات
  int getBatchSize(int totalAyahs) {
    if (totalAyahs < 50) {
      return 10;
    } else if (totalAyahs < 150) {
      return 25;
    } else {
      return 50;
    }
  }

  // تحميل الآيات على دفعات
  Future<void> downloadAyahsInBatches({
    required List<AyahAudioEntity> ayahs,
    required String folderName,
    required List<int> failedAyahs,
  }) async {
    final int batchSize = getBatchSize(ayahs.length);

    for (int i = 0; i < ayahs.length; i += batchSize) {
      final batch = ayahs.skip(i).take(batchSize);
      await Future.wait(batch.map((ayah) => _downloadSingleAyah(
            ayah: ayah,
            folderName: folderName,
            failedAyahs: failedAyahs,
          )));
    }
  }

  // === hifz plans ===
  @override
  Future<Either<Failure, Unit>> addPlan(HifzPlanEntity plan) async {
    try {
      await quranLocalDataSource.addPlan(plan);
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteMultiplePlans(
      List<String> planNames) async {
    try {
      await quranLocalDataSource.deleteMultiplePlans(planNames);
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HifzPlanEntity>>> getAllPlans() async {
    try {
      final result = await quranLocalDataSource.getAllPlans();
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, HifzPlanEntity?>> getPlanByName(
      String planName) async {
    try {
      final result = await quranLocalDataSource.getPlanByName(planName);
      if (result == null) {
        return left(Failure("plan not found"));
      }
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> upsertSurahProgress(
      {required String planName,
      required SurahProgressEntity surahProgress}) async {
    try {
      await quranLocalDataSource.upsertSurahProgress(
          planName: planName, surahProgress: surahProgress);
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}

class SurahDownloadResult {
  final bool success;
  final List<int> failedAyahs;

  const SurahDownloadResult({
    required this.success,
    required this.failedAyahs,
  });
}
