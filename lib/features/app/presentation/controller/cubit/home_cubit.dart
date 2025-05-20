import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/domain/entities/hadith.dart';
import 'package:test_app/features/app/domain/usecases/get_today_hadith_use_case.dart';
import 'package:test_app/features/app/presentation/view/components/custom_alert_dialog.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this.getTodayHadithUseCase,
  ) : super(const HomeState());

  final GetTodayHadithUseCase getTodayHadithUseCase;

  void showTodatHadith(BuildContext context) async {
    Either<Failure, Hadith> result = await getTodayHadithUseCase();
    result.fold((l) => null, (hadith) {
      showCupertinoDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            title: AppStrings.todayHadith,
              alertDialogContent: (context) => SingleChildScrollView(
                    child: Text(hadith.content,
                        textAlign: TextAlign.start,
                        style: TextStyles.bold20(context).copyWith(
                            color: AppColors.white, fontSize: 23)),
                  )));
    });
  }

  void showDawerInCaseLandScape(BuildContext context) {
    emit(state.copyWith(
      isVisible: true,
      opacity: .8,
      width: context.width * 1 / 4,
    ));
  }

  void hideDawerInCaseLandScape() {
    emit(state.copyWith(opacity: 0.0, width: 0.0));

    Future.delayed(AppDurations.longDuration,
        () => emit(state.copyWith(isVisible: false)));
  }
}


