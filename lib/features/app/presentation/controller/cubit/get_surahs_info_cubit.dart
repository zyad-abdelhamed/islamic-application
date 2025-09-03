import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/domain/usecases/get_info_quran_use_case.dart';

part 'get_surahs_info_state.dart';

class GetSurahsInfoCubit extends Cubit<GetSurahsInfoState> {
  GetSurahsInfoCubit(this.useCase) : super(const GetSurahsInfoState()) {
    getData();
  }

  final GetInfoQuranUseCase useCase;
  List<SurahEntity> surahsInfo = [];

  void getData() async {
    final Either<Failure, List<SurahEntity>> result = await useCase();
    result.fold(
        (l) => emit(GetSurahsInfoState(
              state: RequestStateEnum.failed,
              errorMessage: l.message,
            )), (r) {
      surahsInfo = r;
      emit(GetSurahsInfoState(
        state: RequestStateEnum.success,
        surahsInfo: r,
      ));
    });
  }

  void search(String query) {
    if (query.isEmpty) {
      emit(state.copyWith(surahsInfo: surahsInfo));
    }
    final List<SurahEntity> filteredSurahsInfo =
        surahsInfo.where((surah) => surah.name.contains(query)).toList();
    emit(state.copyWith(surahsInfo: filteredSurahsInfo));
  }
}
