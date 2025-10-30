import 'package:hive/hive.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/helper_function/get_from_json.dart';
import 'package:test_app/features/app/data/models/reciters_model.dart';
import 'package:test_app/features/app/data/models/surah_model.dart';
import 'package:test_app/features/app/domain/entities/book_mark_entity.dart';
import 'package:test_app/features/app/domain/entities/hifz_plan_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_audio_dwonload_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_prograss_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_with_tafsir_entity.dart';

// ------------------ Interface ------------------

abstract class QuranLocalDataSource {
  Future<List<SurahModel>> getSurahsInfo();

  // سور مع التفسير
  Future<void> saveSurahWithTafsir(
      {required SurahWithTafsirEntity surah, required String key});
  Future<SurahWithTafsirEntity?> getSurahWithTafsir({required String key});
  Future<void> deleteSurahWithTafsir({required String key});

  // Bookmarks
  Future<void> saveBookMark({required BookMarkEntity bookmarkentity});
  Future<List<BookMarkEntity>> getBookMarks();
  Future<void> deleteBookmarksList({required List<int> indexes});
  Future<void> clearBookMarks();

  // حالة تحميل الصوتيات
  Future<List<RecitersModel>> getReciters({required String surahName});

  Future<void> markSurahAudioAsDownloaded({
    required String edition,
    required String surahName,
    required bool isComplete,
    required List<int> failedAyahs,
  });

  Future<SurahAudioDownloadEntity?> getSurahAudioDownloadInfo({
    required String edition,
    required String surahName,
  });

  Future<void> unmarkSurahAudioDownloaded({
    required String edition,
    required String surahName,
  });
  // ------------------ hifz plans  ------------------
  Future<void> addPlan(HifzPlanEntity plan);

  Future<void> upsertSurahProgress({
    required String planName,
    required SurahProgressEntity surahProgress,
  });

  Future<void> deleteMultiplePlans(List<String> planNames);

  Future<List<HifzPlanEntity>> getAllPlans();

  Future<HifzPlanEntity?> getPlanByName(String planName);
}

// ------------------ Implementation ------------------

class QuranLocalDataSourceImpl implements QuranLocalDataSource {
  static const String bookMarksBoxName = 'book_mark_box';
  static const String quranWithTafsirBoxName = 'quran_with_tafsir_box';
  static const String audioDownloadBoxName = 'audio_download_box';
  static const String hifzPlansBoxName = 'hifz_plans_box';

  final Box<HifzPlanEntity> hifzPlansBox =
      Hive.box<HifzPlanEntity>(hifzPlansBoxName);
  final Box<BookMarkEntity> bookMarksBox =
      Hive.box<BookMarkEntity>(bookMarksBoxName);
  final Box<SurahWithTafsirEntity> quranWithTafsirBox =
      Hive.box<SurahWithTafsirEntity>(quranWithTafsirBoxName);
  final Box<SurahAudioDownloadEntity> audioDownloadBox =
      Hive.box<SurahAudioDownloadEntity>(audioDownloadBoxName);

  // ------------------ سور مع التفسير ------------------

  @override
  Future<void> saveSurahWithTafsir(
      {required SurahWithTafsirEntity surah, required String key}) async {
    await quranWithTafsirBox.put(key, surah);
  }

  @override
  Future<SurahWithTafsirEntity?> getSurahWithTafsir(
      {required String key}) async {
    return quranWithTafsirBox.get(key);
  }

  @override
  Future<void> deleteSurahWithTafsir({required String key}) async {
    await quranWithTafsirBox.delete(key);
  }

  @override
  Future<List<SurahModel>> getSurahsInfo() async {
    final List data = await getJson(RoutesConstants.surahsJsonRouteName);
    final Set downloadedKeys = quranWithTafsirBox.keys.toSet();

    return List.from(
      data.map(
        (json) => SurahModel.fromJson(
          json: json,
          isDwonloaded: downloadedKeys.contains(json['name']),
        ),
      ),
    );
  }

  // ------------------ Bookmarks ------------------

  @override
  Future<List<BookMarkEntity>> getBookMarks() async {
    return bookMarksBox.values.toList();
  }

  @override
  Future<void> saveBookMark({required BookMarkEntity bookmarkentity}) async {
    await bookMarksBox.add(bookmarkentity);
  }

  @override
  Future<void> deleteBookmarksList({required List<int> indexes}) async {
    final keys = indexes.map((index) => bookMarksBox.keyAt(index)).toList();
    await bookMarksBox.deleteAll(keys);
  }

  @override
  Future<void> clearBookMarks() async {
    await bookMarksBox.clear();
  }

  // ------------------ حالة تحميل الصوتيات ------------------

  @override
  Future<List<RecitersModel>> getReciters({required String surahName}) async {
    final data = await getJson(RoutesConstants.recitersJsonRouteName);

    final List<RecitersModel> reciters = await Future.wait(
      (data as List).map((e) async {
        final surahAudioDownloadInfo = await getSurahAudioDownloadInfo(
          edition: e['name'],
          surahName: surahName,
        );

        return RecitersModel.fromJson(
          e,
          surahAudioDownloadInfo: surahAudioDownloadInfo,
        );
      }),
    );

    return reciters;
  }

  @override
  Future<void> markSurahAudioAsDownloaded({
    required String edition,
    required String surahName,
    required bool isComplete,
    required List<int> failedAyahs,
  }) async {
    final key = "${edition}_$surahName";
    final entity = SurahAudioDownloadEntity(
      status: isComplete
          ? SurahAudioDownloadStatus.complete
          : SurahAudioDownloadStatus.partial,
      failedAyahs: failedAyahs,
    );
    await audioDownloadBox.put(key, entity);
  }

  @override
  Future<SurahAudioDownloadEntity?> getSurahAudioDownloadInfo({
    required String edition,
    required String surahName,
  }) async {
    final key = "${edition}_$surahName";
    return audioDownloadBox.get(key);
  }

  @override
  Future<void> unmarkSurahAudioDownloaded({
    required String edition,
    required String surahName,
  }) async {
    final key = "${edition}_$surahName";
    await audioDownloadBox.delete(key);
  }

// ------------------ Plans ------------------
  @override
  Future<void> addPlan(HifzPlanEntity plan) async {
    await hifzPlansBox.put(plan.planName, plan);
  }

  @override
  Future<void> deleteMultiplePlans(List<String> planNames) async {
    if (planNames.isEmpty) return;
    await hifzPlansBox.deleteAll(planNames);
  }

  @override
  Future<List<HifzPlanEntity>> getAllPlans() async {
    return hifzPlansBox.values.toList(growable: false);
  }

  @override
  Future<HifzPlanEntity?> getPlanByName(String planName) async {
    return hifzPlansBox.get(planName);
  }

  @override
  Future<void> upsertSurahProgress({
    required String planName,
    required SurahProgressEntity surahProgress,
  }) async {
    final plan = hifzPlansBox.get(planName);
    if (plan == null) throw Exception('Plan not found: $planName');

    final updatedSurahs = List<SurahProgressEntity>.from(plan.surahsProgress);
    final index = updatedSurahs.indexWhere(
      (surah) => surah.surahName == surahProgress.surahName,
    );

    if (index != -1) {
      updatedSurahs[index] = SurahProgressEntity(
        surahName: surahProgress.surahName,
        memorizedAyahs: surahProgress.memorizedAyahs,
      );
    } else {
      updatedSurahs.add(surahProgress);
    }

    final updatedPlan = HifzPlanEntity(
      planName: plan.planName,
      createdAt: plan.createdAt,
      lastProgress: surahProgress.surahName,
      surahsProgress: updatedSurahs,
    );

    await hifzPlansBox.put(planName, updatedPlan);
  }
}
