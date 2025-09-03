import 'package:flutter/material.dart';

class SettingsController {
  SettingsController() {
    pageState = ValueNotifier(SettingsPageState.idle);
  }

  late final ValueNotifier<SettingsPageState> pageState;

  void dispose() {
    pageState.dispose();
  }
}

enum SettingsPageState { idle, loading, deletingAllData }
