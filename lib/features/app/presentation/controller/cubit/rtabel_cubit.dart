import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/models/booleans_model.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/domain/usecases/get_booleans_use_case.dart';
import 'package:test_app/features/app/domain/usecases/reset_booleans_use_case.dart';
import 'package:test_app/features/app/domain/usecases/update_booleans_use_case.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/features/app/presentation/controller/cubit/rtabel_state.dart';

class RtabelCubit extends Cubit<RtabelState> {
  RtabelCubit(
    this.getBooleansUseCase,
    this.resetBooleansUseCase,
    this.updateBooleansUseCase,
  ) : super(const RtabelState());

  final GetBooleansUseCase getBooleansUseCase;
  final ResetBooleansUseCase resetBooleansUseCase;
  final UpdateBooleansUseCase updateBooleansUseCase;

  static RtabelCubit controller(BuildContext context) =>
      context.read<RtabelCubit>();

  Future<void> loadCheckBoxValues() async {
    emit(state.copyWith(requestState: RequestStateEnum.loading));

    Either<Failure, List<bool>> result = await getBooleansUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
        errorMessage: failure.message,
        requestState: RequestStateEnum.failed,
      )),
      (checkBoxValues) => emit(state.copyWith(
        checkBoxsValues: checkBoxValues,
        requestState: RequestStateEnum.success,
      )),
    );
  }

  void changeCheckBoxValue(
    BuildContext context,
      {required int index,
      required bool newValue,
      required ValueNotifier<bool?> notifier}) async {
    final result = await updateBooleansUseCase(
      parameters: BooleansParameters(key: index, value: newValue),
    );
    result.fold(
        (failure) {
          appSneakBar(context: context, message: failure.message, isError: true);
        }, (checkBoxValues) {
      notifier.value = newValue;
    });
  }

  void resetAllCheckBoxes() async {
    emit(state.copyWith(requestState: RequestStateEnum.loading));

    final result = await resetBooleansUseCase();

    result.fold(
        (failure) => emit(state.copyWith(
              errorMessage: failure.message,
              requestState: RequestStateEnum.failed,
            )),
        (checkBoxValues) => loadCheckBoxValues());
  }
}
