import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:test_app/core/theme/dark_theme.dart';
import 'package:test_app/core/theme/light_theme.dart';

class ThemeCubit extends HydratedCubit<bool> {
  ThemeCubit() : super(false); // false = light mode by default

  ThemeData get theme => state ? darkTheme : lightTheme;

  static ThemeCubit controller(BuildContext context) =>
      context.read<ThemeCubit>();

  void toggleTheme() => emit(!state);

  @override
  bool fromJson(Map<String, dynamic> json) {
    return json['isDark'] as bool? ?? false;
  }

  @override
  Map<String, dynamic> toJson(bool state) {
    return {'isDark': state};
  }

  void changeTheme(bool value) {}
}
