import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';
import 'package:test_app/features/app/domain/entities/ayah_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';

part 'get_speciffic_ayahs_state.dart';

class GetSpecifficAyahsCubit extends Cubit<GetSpecifficAyahsState> {
  GetSpecifficAyahsCubit(this._baseQuranRepo)
      : super(GetSpecifficAyahsInitial());

  final BaseQuranRepo _baseQuranRepo;

  Future<void> getSpecificAyahs(
      {required SurahRequestParams surahRequestParams}) async {
    emit(GetSpecifficAyahsLoading());

    final Either<Failure, List<AyahEntity>> result = await _baseQuranRepo
        .getSpecificAyahs(surahRequestParams: surahRequestParams);

    result.fold(
      (Failure failure) => emit(GetSpecifficAyahsFailure(failure.message)),
      (List<AyahEntity> ayahs) => emit(GetSpecifficAyahsSuccess(ayahs)),
    );
  }
}
