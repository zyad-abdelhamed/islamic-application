import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/cache_constants.dart';
import 'package:test_app/core/services/cache_service.dart';

part 'rtabel_state.dart';

class RtabelCubit extends Cubit<RtabelState> {
  RtabelCubit() : super(RtabelState());

  static RtabelCubit getRamadanTableController(BuildContext context) {
    final RtabelCubit controller = context.read<RtabelCubit>();
    return controller;
  }

  void setCheckBoxValue({required int index, required bool value}) async {
    // baseCache.insertBoolToCache(
    //     key: CacheConstants.getRamadanTableCheckBoxKey(index: index),
    //     value: value);
  }

  void loadCheckBoxValues() async {
    // emit(RtabelState(
    //     checkBoxsValues: List<bool>.generate(16 * 30, (index) {
    //   return baseCache.getboolFromCache(
    //           key: CacheConstants.getRamadanTableCheckBoxKey(index: index)) ??
    //       false;
    // })));
  }

  changeCheckBoxValue({required int index, required bool newValue}) {
    state.checkBoxsValues![index] = newValue; //change new value
    setCheckBoxValue(index: index, value: newValue); //cache new value
    emit(RtabelState());
  }
}
