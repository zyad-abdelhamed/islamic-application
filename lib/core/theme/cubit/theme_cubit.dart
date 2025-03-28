import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:test_app/core/theme/app_theme.dart';

part 'theme_state.dart';

class ThemeCubit with ChangeNotifier {
  ThemeData _appTheme = lightTheme;
  ThemeData get appTheme => _appTheme;
  set appTheme(ThemeData theme) {
    _appTheme = theme;
    notifyListeners();
  }

  void changeTheme() {
   _appTheme == lightTheme ? appTheme = darkTheme  : appTheme = lightTheme;
  }
}
