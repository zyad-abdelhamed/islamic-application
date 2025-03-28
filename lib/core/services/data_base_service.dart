import 'package:hive/hive.dart';

abstract class BaseDataBaseService<T> {
  Future<void> add(T item, String path);
  Future<List<T>> get(String path);
  Future<void> addAll(List<T> items, String path);
  Future<void> delete(dynamic id, String path);
  Future<void> deleteAll(String path);
}

class HiveDatabaseService<T> implements BaseDataBaseService<T> {
  @override
  Future<void> add(T item, String path) async {
    await Hive.box(path).add(item);
  }

  @override
  Future<List<T>> get(String path) async {
    return Future.value(Hive.box(path).values as List<T>);
  }

  @override
  Future<void> addAll(List<T> items, String path) async {
    await Hive.box(path).addAll(items);
  }

  @override
  Future<void> delete(dynamic id, String path) async {
    // await Hive.box(path).delete(id);
    // تأكد من أن الـ index صالح
    if (Hive.box(path).length > id) {
      var key =
          Hive.box(path).keyAt(id); // الحصول على المفتاح عند الفهرس المحدد
      await Hive.box(path).delete(key); // حذف العنصر باستخدام المفتاح
    }
  }

  @override
  Future<void> deleteAll(String path) async {
    await Hive.box(path).clear();
  }
}
