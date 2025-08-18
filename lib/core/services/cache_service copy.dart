import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseCacheService {
  void cacheintIalization();
  Future<bool> insertStringToCache(
      {required String key, required String value});
  String? getStringFromCache({required String key});
  Future<bool> insertIntToCache({required String key, required int value});
  int? getIntFromCache({required String key});
  Future<bool> insertBoolToCache({required String key, required bool value});
  bool? getboolFromCache({required String key});
  Future<bool> insertDoubelToCache(
      {required String key, required double value});
  double? getDoubelFromCache({required String key});
  Future<bool> deletecache({required String key});
}

class CacheImplBySharedPreferences extends BaseCacheService {
  late final  SharedPreferences _sharedPreferences;

  //ialization
  @override
  void cacheintIalization() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //string
  @override
  Future<bool> insertStringToCache(
      {required String key, required String value}) async {
    return await _sharedPreferences.setString(key, value);
  }

  @override
  String? getStringFromCache({required String key}) {
    return _sharedPreferences.getString(key);
  }

  //int
  @override
  Future<bool> insertIntToCache(
      {required String key, required int value}) async {
    return await _sharedPreferences.setInt(key, value);
  }

  @override
  int? getIntFromCache({required String key}) {
    return _sharedPreferences.getInt(key);
  }

  //bool
  @override
  Future<bool> insertBoolToCache(
      {required String key, required bool value}) async {
    return await _sharedPreferences.setBool(key, value);
  }

  @override
  bool? getboolFromCache({required String key}) {
    return _sharedPreferences.getBool(key);
  }

  //doubel
  @override
  Future<bool> insertDoubelToCache(
      {required String key, required double value}) async {
    return await _sharedPreferences.setDouble(key, value);
  }

  @override
  double? getDoubelFromCache({required String key}) {
    return _sharedPreferences.getDouble(key);
  }

  //delete
  @override
  Future<bool> deletecache({required String key}) async {
    return await _sharedPreferences.remove(key);
  }
}
