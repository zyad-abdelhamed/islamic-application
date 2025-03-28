import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseCache {

  Future<void> cacheintIalization();
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

class CacheImplBySharedPreferences extends BaseCache {
    late final SharedPreferences sharedPreferences;

  //ialization
  @override
  Future<void> cacheintIalization() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  //string
  @override
  Future<bool> insertStringToCache(
      {required String key, required String value}) async {
    return await sharedPreferences.setString(key, value);
  }

  @override
  String? getStringFromCache({required String key}) {
    return sharedPreferences.getString(key);
  }

  //int
  @override
  Future<bool> insertIntToCache(
      {required String key, required int value}) async {
    return await sharedPreferences.setInt(key, value);
  }

  @override
  int? getIntFromCache({required String key}) {
    return sharedPreferences.getInt(key);
  }

  //bool
  @override
  Future<bool> insertBoolToCache(
      {required String key, required bool value}) async {
    return await sharedPreferences.setBool(key, value);
  }

  @override
  bool? getboolFromCache({required String key}) {
    return sharedPreferences.getBool(key);
  }

  //doubel
  @override
  Future<bool> insertDoubelToCache(
      {required String key, required double value}) async {
    return await sharedPreferences.setDouble(key, value);
  }

  @override
  double? getDoubelFromCache({required String key}) {
    return sharedPreferences.getDouble(key);
  }

  //delete
  @override
  Future<bool> deletecache({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}
