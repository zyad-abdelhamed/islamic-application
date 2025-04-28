import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:test_app/core/constants/data_base_constants.dart';
import 'package:test_app/core/services/data_base_service.dart';
import 'package:test_app/core/theme/dark_theme.dart';
import 'package:test_app/core/theme/light_theme.dart';

BaseDataBaseService<bool> hiveCacheVariblesInstance = HiveDatabaseService<bool>(
    box: Hive.box<bool>(DataBaseConstants.cacheVariblesHiveKey));

class ThemeProvider with ChangeNotifier {
  bool _darkMode = hiveCacheVariblesInstance.getValue('darkMode') ?? false;
  bool get darkMpde => _darkMode;
  ThemeData _appTheme = hiveCacheVariblesInstance.getValue('darkMode') ?? false
      ? darkTheme
      : lightTheme;
  ThemeData get appTheme => _appTheme;
  void _setVaribles(ThemeData theme, bool darkMode) {
    _darkMode = darkMode;
    _appTheme = theme;
    notifyListeners();
    hiveCacheVariblesInstance.put('darkMode', darkMode);
  }

  void changeTheme() {
    _appTheme == lightTheme
        ? _setVaribles(darkTheme, true)
        : _setVaribles(lightTheme, false);
  }
}
