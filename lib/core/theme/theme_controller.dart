import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.dark);

  bool enableSavingState = true;
  static ThemeCubit controller(BuildContext context) =>
      context.read<ThemeCubit>();

  /// Save theme state (Hydrated)
  void toggleTheme(ThemeMode themeMode) {
    emit(themeMode); // This will be saved automatically by HydratedCubit
  }

  /// Change theme WITHOUT saving state
  void toggleThemeWithoutSaveState() {
    final ThemeMode newMode;

    enableSavingState = false; // Disable saving state temporarily.

    newMode = (state == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    emit(newMode); // toggle theme.

    enableSavingState = true; // Enable saving state again.
  }

  @override
  ThemeMode fromJson(Map<String, dynamic> json) {
    final mode = json['theme'] as String?;
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }

  @override
  Map<String, dynamic> toJson(ThemeMode state) {
    if (!enableSavingState) return {}; // disable saving state

    String mode;
    switch (state) {
      case ThemeMode.light:
        mode = 'light';
        break;
      case ThemeMode.dark:
        mode = 'dark';
        break;
      case ThemeMode.system:
        mode = 'system';
        break;
    }
    return {'theme': mode};
  }
}
