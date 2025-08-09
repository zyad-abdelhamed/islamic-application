import 'package:hive/hive.dart';
import 'package:test_app/features/app/data/models/surah_model.dart';
import 'package:test_app/features/app/domain/entities/book_mark_entity.dart';

abstract class QuranLocalDataSource {
  Future<List<SurahModel>> getInfoQuran({required String part});
  Future<void> saveBookMark({required BookMarkEntity bookmarkentity});
  Future<List<BookMarkEntity>> getBookMarks();
  Future<void> deleteBookMark({required int index});
  Future<void> clearBookMarks();
}

class QuranLocalDataSourceImpl implements QuranLocalDataSource {
  static const String _boxName = 'book_mark_box';
  static const String _key = 'book_mark_key';

  @override
  Future<List<SurahModel>> getInfoQuran({required String part}) {
    // TODO: implement getInfoQuran
    throw UnimplementedError();
  }

  @override
  Future<List<BookMarkEntity>> getBookMarks() async {
    final box = await Hive.openBox<BookMarkEntity>(_boxName);
    return box.values.toList();
  }

  @override
  Future<void> saveBookMark({required BookMarkEntity bookmarkentity}) async {
    final box = await Hive.openBox<BookMarkEntity>(_boxName);
    await box.put(_key, bookmarkentity);
  }

  @override
  Future<void> deleteBookMark({required int index}) async {
    final box = await Hive.openBox<BookMarkEntity>(_boxName);
    final key = box.keyAt(index);
    await box.delete(key);
  }

  @override
  Future<void> clearBookMarks() async {
    final box = await Hive.openBox<BookMarkEntity>(_boxName);
    await box.clear();
  }
}
