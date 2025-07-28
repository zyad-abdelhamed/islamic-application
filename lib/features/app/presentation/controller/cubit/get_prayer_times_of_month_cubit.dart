import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/features/app/data/models/get_prayer_times_of_month_prameters.dart';
import 'package:test_app/features/app/domain/entities/timings.dart';
import 'package:test_app/features/app/domain/usecases/get_prayer_times_of_month_use_case.dart';

part 'get_prayer_times_of_month_state.dart';

class GetPrayerTimesOfMonthCubit extends Cubit<GetPrayerTimesOfMonthState> {
  GetPrayerTimesOfMonthCubit(this.getPrayerTimesOfMonthUseCase)
      : super(const GetPrayerTimesOfMonthState()) {
    getPrayerTimesOfMonth(GetPrayerTimesOfMonthPrameters(date: DateTime.now()));
  }

  final GetPrayerTimesOfMonthUseCase getPrayerTimesOfMonthUseCase;

  static GetPrayerTimesOfMonthCubit controller(BuildContext context) =>
      context.read<GetPrayerTimesOfMonthCubit>();

  void getPrayerTimesOfMonth(
      GetPrayerTimesOfMonthPrameters getPrayerTimesOfMonthPrameters) async {
    emit(GetPrayerTimesOfMonthState(
        getPrayerTimesOfMonthState: RequestStateEnum.loading));
    final Either<Failure, List<Timings>> result =
        await getPrayerTimesOfMonthUseCase(
            parameters: getPrayerTimesOfMonthPrameters);
    result.fold(
      (l) {
        emit(GetPrayerTimesOfMonthState(
            getPrayerTimesOfMonthErrorMeassage: l.message));
      },
      (prayerTimesOfMonth) {
        emit(
            GetPrayerTimesOfMonthState(prayerTimesOfMonth: prayerTimesOfMonth));
      },
    );
  }
}
