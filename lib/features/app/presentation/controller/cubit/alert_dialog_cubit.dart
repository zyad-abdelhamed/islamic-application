import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';

part 'alert_dialog_state.dart';

class AlertDialogCubit extends Cubit<AlertDialogState> {
  AlertDialogCubit() : super(AlertDialogState());
  //events
  void drawCircle(BuildContext context) {
    emit(AlertDialogState(progress: state.progress + 1));
    if (state.progress == 100) {
      Navigator.pop(context);
    }
  }

  void drawRosaryRing(BuildContext context) {
    emit(AlertDialogState(
        progress: state.progress + 1, selectedIndex: state.selectedIndex));

    if (state.progress == 3) {
      _incrementSelectedIndex();
      Future.delayed(
          AppDurations.mediumDuration,
          () => emit(AlertDialogState(
              progress: 0.0, selectedIndex: _incrementSelectedIndex())));
      _pop(context);
    }
  }

  //helper function
  int _incrementSelectedIndex() => state.selectedIndex + 1;
  void _pop(BuildContext context) {
    if (state.selectedIndex == AppStrings.ringRosaryTexts.length - 1) {
      Future.delayed(
          AppDurations.longDuration, () => Navigator.pop(context));
    }
  }
}
