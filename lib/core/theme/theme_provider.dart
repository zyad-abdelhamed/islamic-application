import 'package:flutter/material.dart';
import 'package:test_app/core/theme/dark_theme.dart';
import 'package:test_app/core/theme/light_theme.dart';

class ThemeCubit with ChangeNotifier {
  bool _darkMode = false;
  bool get darkMpde => _darkMode;
  ThemeData _appTheme = lightTheme;
  ThemeData get appTheme => _appTheme;
  void _setVaribles(ThemeData theme,bool darkMode) {
    _darkMode = darkMode;
    _appTheme = theme;
    notifyListeners();
  }
  void changeTheme() {
    _appTheme == lightTheme ? _setVaribles(darkTheme, true) : _setVaribles(lightTheme, false);
  }
}
