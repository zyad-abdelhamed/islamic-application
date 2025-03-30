import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/view_constants.dart';

part 'elec_rosary_state.dart';

class ElecRosaryCubit extends Cubit<ElecRosaryState> {
  ElecRosaryCubit() : super(ElecRosaryState());
  static ElecRosaryCubit getAuthController(BuildContext context) {
    final ElecRosaryCubit controller = context.read<ElecRosaryCubit>();
    return controller;
  }

  //elec rosary events
  void increaseCounter() {
    _slideAnimation(counter: state.counter + 1, slideValue: -.6);
  }

  void resetCounter() {
    if (state.counter != 0) {
      _slideAnimation(counter: 0, slideValue: .6);
    }
    return;
  }

  void _slideAnimation({required int counter, required double slideValue}) {
    emit(state.copyWith(
        opacity: 0.0, offset: Offset(0, slideValue))); //start animation

    Future.delayed(ViewConstants.duration, () {
      emit(state.copyWith(counter: counter, opacity: 1.0, offset: Offset.zero));
    }); //reverse animation and stop
  }

  //featured events
  //to do
}
