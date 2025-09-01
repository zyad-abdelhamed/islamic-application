import 'package:flutter/material.dart';

class SettingsController {
  SettingsController() : pageState = ValueNotifier(SettingsPageState.idle);

  final ValueNotifier<SettingsPageState> pageState;
  void dispose() => pageState.dispose();
}

enum SettingsPageState { idle, loading, deletingAllData }
