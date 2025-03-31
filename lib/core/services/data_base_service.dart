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
    //return Future.value(Hive.box(path).values as List<T>);
    var box = Hive.box<T>(path); // تأكد من أن الصندوق معرف بنوع T
    return box.values.toList();
  }

  @override
  Future<void> addAll(List<T> items, String path) async {
    await Hive.box(path).addAll(items);
  }

  @override
  Future<void> delete(dynamic id, String path) async {
    var box = await Hive.openBox<T>(path);
    if (box.containsKey(id)) {
      await box.delete(id); // حذف باستخدام المفتاح مباشرة إذا كان متاحًا
    } else if (id is int && id < box.length) {
      var key = box.keyAt(id); // إذا كان id رقمًا، نحاول استخدام keyAt
      await box.delete(key);
    }
  }

  @override
  Future<void> deleteAll(String path) async {
    await Hive.box(path).clear();
  }

  
}
