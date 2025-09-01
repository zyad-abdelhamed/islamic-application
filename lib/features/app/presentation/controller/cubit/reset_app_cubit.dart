import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/domain/repositories/base_app_repo.dart';

part 'reset_app_state.dart';

class ResetAppCubit extends Cubit<ResetAppState> {
  ResetAppCubit(this.appRepo) : super(ResetAppInitial());

  final BaseAppRepo appRepo;

  void resetApp() async {
    emit(ResetAppLoading());

    final Either<Failure, Unit> result = await appRepo.resetApp();

    result.fold(
      (failure) => emit(ResetAppError(failure.message)),
      (_) => emit(ResetAppSuccess()),
    );
  }
}
