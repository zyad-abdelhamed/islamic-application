import 'package:hive/hive.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/helper_function/get_from_json.dart';
import 'package:test_app/features/app/data/models/surah_model.dart';
import 'package:test_app/features/app/domain/entities/book_mark_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_with_tafsir_entity.dart';

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
}

class QuranLocalDataSourceImpl implements QuranLocalDataSource {
  static const String bookMarksBoxName = 'book_mark_box';
  static const String quranWithTafsirBoxName = 'quran_with_tafsir_box';

  final Box<BookMarkEntity> bookMarksBox =
      Hive.box<BookMarkEntity>(bookMarksBoxName);
  final Box<SurahWithTafsirEntity> quranWithTafsirBox =
      Hive.box<SurahWithTafsirEntity>(quranWithTafsirBoxName);

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

    // كل المفاتيح اللي محفوظة في الصندوق (يعني السور اللي نزلت بالتفسير)
    final Set downloadedKeys = quranWithTafsirBox.keys.toSet();

    return List.from(
      data
          .map(
            (json) => SurahModel.fromJson(
              json: json,
              isDwonloaded: downloadedKeys.contains(json['name']),
            ),
          )
          .toList(),
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
}
