import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_durations.dart';

part 'elec_rosary_state.dart';

class ElecRosaryCubit extends Cubit<ElecRosaryState> {
 int counter = 1000000;

  ElecRosaryCubit() : super(ElecRosaryState());
  static ElecRosaryCubit getElecRosaryController(BuildContext context) {
    final ElecRosaryCubit controller = context.read<ElecRosaryCubit>();
    return controller;
  }

  //elec rosary events
  void increaseCounter() {
    counter++;
    _slideAnimation(slideValue: -.6);
  }

  void resetCounter() {
    if (counter != 0) {
      counter = 0;
      _slideAnimation(slideValue: .6);
    }
    return;
  }

  void _slideAnimation({required double slideValue}) {
    emit(state.copyWith(
        opacity: 0.0, offset: Offset(0, slideValue))); //start animation

    Future.delayed(AppDurations.lowDuration, () {
      emit(state.copyWith(opacity: 1.0, offset: Offset.zero));
    }); //reverse animation and stop
  }
}
