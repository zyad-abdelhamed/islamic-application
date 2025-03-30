import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'alert_dialog_state.dart';

class AlertDialogCubit extends Cubit<AlertDialogState> {
  AlertDialogCubit() : super(AlertDialogState());
  void drawCircle(BuildContext context) {
    emit(AlertDialogState(progress: state.progress + 1));
    if (state.progress == 100) {
      Navigator.pop(context);
    }
  }
}
