import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/domain/usecases/get_today_hadith_use_case.dart';
import 'package:test_app/features/app/presentation/view/components/custom_alert_dialog.dart';

class HadithCubit extends HydratedCubit<String> {
  HadithCubit(this.getTodayHadithUseCase) : super('');

  final GetTodayHadithUseCase getTodayHadithUseCase;

  Future<void> showTodayHadith(BuildContext context) async {
    if (await canRunToday()) {
      final result = await getTodayHadithUseCase();
      result.fold(
        (failure) {
          debugPrint('Failed to load hadith: ${failure.message}');
        },
        (hadith) {
          showCupertinoDialog(
            context: context,
            builder: (_) => CustomAlertDialog(
              alertDialogContent: (ctx) => SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'حديث اليوم',
                      style: TextStyles.semiBold32auto(ctx)
                          .copyWith(color: AppColors.secondryColor),
                    ),
                    Text(
                      hadith.content,
                      style: TextStyles.bold20(ctx)
                          .copyWith(color: AppColors.white, fontSize: 23),
                    ),
                  ],
                ),
              ),
              title: '',
              iconWidget: (BuildContext context) => Icon(
                Icons.menu_book_rounded,
                size: 32,
                color: AppColors.secondryColor,
              ),
            ),
          );
        },
      );
    }
  }

  Future<bool> canRunToday() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (state != today) {
      emit(today);
      return true;
    }
    return false;
  }

  @override
  String fromJson(Map<String, dynamic> json) {
    return (json['lastRunDate'] as String?) ?? '';
  }

  @override
  Map<String, dynamic> toJson(String state) {
    return {'lastRunDate': state};
  }
}
