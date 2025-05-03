import 'package:hive/hive.dart';

abstract class BaseDataBaseService<T> {
  Future<void> add(T item, String? path);
  Future<void> put(dynamic key, T item); 
  Future<void> putAt(int index, T item);
  Future<List<T>> get(String path);
  T? getValue(String path);
  Future<void> addAll(List<T> items, String path);
  Future<void> delete(dynamic id, String path);
  Future<void> deleteAll(String path);
  Future<void> putAll(Map<dynamic, T> entries); 
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
    List<T> list = [];
    for (int i = 0; i < box.length; i++) {
      list.add(box.getAt(i)!);
    }
    return list;
  }

  @override
  Future<void> addAll(List<T> items, String path) async {
    await box.addAll(items);
  }

  @override
  Future<void> delete(dynamic id, String path) async {
    if (box.length > id) {
      var key = box.keyAt(id);
      await box.delete(key);
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
  Future<void> put(dynamic key, T item) {
    return box.put(key, item);
  }

  @override
  Future<void> putAt(int index, T item) {
    return box.putAt(index, item);
  }

  @override
  Future<void> putAll(Map<dynamic, T> entries) async {
    await box.putAll(entries);
  }
}
