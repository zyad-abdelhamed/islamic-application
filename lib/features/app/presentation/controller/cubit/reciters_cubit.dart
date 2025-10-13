import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';

part 'reciters_state.dart';

class RecitersCubit extends Cubit<RecitersState> {
  RecitersCubit(this._baseQuranRepo) : super(RecitersInitial());
  final BaseQuranRepo _baseQuranRepo;
  Future<void> getReciters({required String surahName}) async {
    emit(RecitersLoading());
    final Either<Failure, List<ReciterEntity>> result =
        await _baseQuranRepo.getReciters(surahName: surahName);
    result.fold((l) => emit(RecitersFailure(l.message)), (r) {
      emit(RecitersLoaded(r));
    });
  }
}
