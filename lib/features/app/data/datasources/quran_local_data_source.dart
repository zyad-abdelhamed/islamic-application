import 'package:hive/hive.dart';
import 'package:test_app/features/app/data/models/surah_model.dart';
import 'package:test_app/features/app/domain/entities/book_mark_entity.dart';

abstract class QuranLocalDataSource {
  Future<List<SurahModel>> getInfoQuran({required String part});
  Future<void> saveBookMark({required BookMarkEntity bookmarkentity});
  Future<List<BookMarkEntity>> getBookMarks();
  Future<void> deleteBookmarksList({required List<int> indexes});
  Future<void> clearBookMarks();
}

class QuranLocalDataSourceImpl implements QuranLocalDataSource {
  static const String bookMarksBoxName = 'book_mark_box';
  
  final  Box<BookMarkEntity> _box = Hive.box<BookMarkEntity>(bookMarksBoxName);

  @override
  Future<List<SurahModel>> getInfoQuran({required String part}) {
    // TODO: implement getInfoQuran
    throw UnimplementedError();
  }

  @override
  Future<List<BookMarkEntity>> getBookMarks() async {
    return _box.values.toList();
  }

  @override
  Future<void> saveBookMark({required BookMarkEntity bookmarkentity}) async {
    await _box.add(bookmarkentity);
  }

  @override
  Future<void> deleteBookmarksList({required List<int> indexes}) async {
  final keys = indexes.map((index) => _box.keyAt(index)).toList();
  await _box.deleteAll(keys);
}


  @override
  Future<void> clearBookMarks() async {
    await _box.clear();
  }
}
