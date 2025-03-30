import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/app/domain/entities/timings.dart';
import 'package:test_app/app/domain/usecases/get_prayers_times_use_case.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/enums.dart';

part 'prayer_times_state.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  final GetPrayersTimesUseCase getPrayersTimesUseCase;
  PrayerTimesCubit(this.getPrayersTimesUseCase) : super(PrayerTimesState());
  List<String> getListOfTimings(PrayerTimesState state) {
    return [
      state.prayerTimes!.fajr,
      state.prayerTimes!.sunrise,
      state.prayerTimes!.dhuhr,
      state.prayerTimes!.asr,
      state.prayerTimes!.maghrib,
      state.prayerTimes!.isha
    ];
  }

  getPrayersTimes() async {
    Either<Failure, Timings> result = await getPrayersTimesUseCase();
    result.fold(
      (l) {
        print('error');
        emit(PrayerTimesState(
            errorMessageofPrayerTimes: l.message,
            requestStateofPrayerTimes: RequestStateEnum.failed));
      },
      (r) {
        print('success');
        emit(PrayerTimesState(
            prayerTimes: r,
            requestStateofPrayerTimes: RequestStateEnum.success));
      },
    );
  }
}
