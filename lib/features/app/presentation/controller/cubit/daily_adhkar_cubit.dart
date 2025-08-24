import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/domain/entities/daily_adhkar_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_daily_adhkar_repo.dart';
import 'daily_adhkar_state.dart';

class DailyAdhkarCubit extends Cubit<DailyAdhkarState> {
  final BaseDailyAdhkarRepo repo;

  DailyAdhkarCubit(this.repo) : super(DailyAdhkarInitial());

  static DailyAdhkarCubit get(context) =>
      BlocProvider.of<DailyAdhkarCubit>(context);

  Future<void> getAllDailyAdhkar() async {
    emit(DailyAdhkarLoading());
    final result = await repo.getAllDailyAdhkar();
    result.fold(
      (failure) => emit(DailyAdhkarError(failure.message)),
      (list) => emit(DailyAdhkarLoaded(list)),
    );
  }

  Future<void> addDailyAdhkar(DailyAdhkarEntity entity) async {
    emit(DailyAdhkarAdding());
    final result = await repo.addDailyAdhkar(entity: entity);
    result.fold(
      (failure) => emit(DailyAdhkarError(failure.message)),
      (_) => emit(DailyAdhkarAddSuccess()),
    );
  }

  Future<void> deleteDailyAdhkar(int index) async {
    emit(DailyAdhkarDeleting());
    final result = await repo.deleteDailyAdhkar(index: index);
    result.fold(
      (failure) => emit(DailyAdhkarError(failure.message)),
      (_) => emit(DailyAdhkarDeleteSuccess()),
    );
  }
}
