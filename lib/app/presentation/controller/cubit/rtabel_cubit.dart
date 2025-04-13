import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app/domain/usecases/get_booleans_use_case.dart';
import 'package:test_app/app/domain/usecases/reset_booleans_use_case.dart';
import 'package:test_app/app/domain/usecases/update_booleans_use_case.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/enums.dart';

part 'rtabel_state.dart';

class RtabelCubit extends Cubit<RtabelState> {
  RtabelCubit(this.getBooleansUseCase, this.resetBooleansUseCase,
      this.updateBooleansUseCase)
      : super(const RtabelState());

  final GetBooleansUseCase getBooleansUseCase;
  final ResetBooleansUseCase resetBooleansUseCase;
  final UpdateBooleansUseCase updateBooleansUseCase;

  static RtabelCubit getRamadanTableController(BuildContext context) {
    final RtabelCubit controller = context.read<RtabelCubit>();
    return controller;
  }

  void setCheckBoxValue({required int index, required bool value}) async {}

  void loadCheckBoxValues() async {
    Either<Failure, List<bool>> result = await getBooleansUseCase();
    result.fold(
        (l) => emit(RtabelState(
            errorMessage: l.message, requestState: RequestStateEnum.failed)),
        (r) => emit(RtabelState(
            checkBoxsValues: r, requestState: RequestStateEnum.success)));
  }

  changeCheckBoxValue({required int index, required bool newValue}) {
    state.checkBoxsValues[index] = newValue; //change new value
    setCheckBoxValue(index: index, value: newValue); //cache new value
    emit(RtabelState());
  }
}
