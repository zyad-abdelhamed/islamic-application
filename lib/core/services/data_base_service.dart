import 'package:hive/hive.dart';

abstract class BaseDataBaseService<T> {
  Future<void> add(T item, String? path);
  Future<void> put(T item, String path);
    Future<void> putAt(T item, int index);

  Future<List<T>> get(String path);
  T? getValue(String path);
  Future<void> addAll(List<T> items, String path);
  Future<void> delete(dynamic id, String path);
  Future<void> deleteAll(String path);
}

class HiveDatabaseService<T> implements BaseDataBaseService<T> {
  final Box<T> box;
  
  HiveDatabaseService({required this.box});
  @override
  Future<void> add(T item, String? path) async {
    await box.add(item);
  }

  @override
  Future<List<T>> get(String path) async {
    return Future.value(box.values.toList());
  }

  @override
  Future<void> addAll(List<T> items, String path) async {
    await box.addAll(items);
  }

  @override
  Future<void> delete(dynamic id, String path) async {
    // await box.delete(id);
    // تأكد من أن الـ index صالح
    if (box.length > id) {
      var key =
          box.keyAt(id); // الحصول على المفتاح عند الفهرس المحدد
      await box.delete(key); // حذف العنصر باستخدام المفتاح
    }
  }

  @override
  Future<void> deleteAll(String path) async {
    await box.clear();
  }
  
  @override
  T? getValue(String path) {
    return box.get(path);
  }
  
  @override
  Future<void> put(T item, String path) {
    return box.put(path, item);
  }
  
  @override
  Future<void> putAt(T item, int index) {
   return box.putAt(index, item);
  }

  
}
