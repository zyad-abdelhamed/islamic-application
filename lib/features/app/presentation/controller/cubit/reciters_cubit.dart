import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_reciters_repo.dart';

part 'reciters_state.dart';

class RecitersCubit extends Cubit<RecitersState> {
  RecitersCubit(this.baseRecitersRepo) : super(RecitersInitial());
  final BaseRecitersRepo baseRecitersRepo;
  Future<void> getReciters() async {
    emit(RecitersLoading());
    final result = await baseRecitersRepo.getReciters();
    result.fold((l) => emit(RecitersFailure(l.message)), (r) {
      print("${r[1].image}=====================================");
      emit(RecitersLoaded(r));
    });
  }
}
