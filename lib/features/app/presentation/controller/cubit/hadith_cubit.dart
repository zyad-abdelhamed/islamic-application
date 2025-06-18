import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/domain/entities/hadith.dart';
import 'package:test_app/features/app/domain/usecases/get_today_hadith_use_case.dart';
import 'package:test_app/features/app/presentation/view/components/custom_alert_dialog.dart';

class HadithCubit extends HydratedCubit<String> {
  HadithCubit(this.getTodayHadithUseCase) : super('null');

  final GetTodayHadithUseCase getTodayHadithUseCase;

  // عرض حديث اليوم إذا لم يكن قد تم عرضه من قبل اليوم
  void showTodatHadith(BuildContext context) async {
    // التحقق من إذا تم عرض الحديث اليوم بالفعل
    if (await canRunToday()) {
      Either<Failure, Hadith> result = await getTodayHadithUseCase();
      result.fold((l) => print(l.message), (hadith) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            alertDialogContent: (context) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Text>[
                  Text('حديث اليوم|',
                      style: TextStyles.semiBold32auto(context)
                          .copyWith(color: AppColors.secondryColor)),
                  Text(hadith.content,
                      textAlign: TextAlign.start,
                      style: TextStyles.bold20(context).copyWith(
                          color: AppColors.white, fontSize: 23)),
                ],
              ),
            ), title: '',
          ),
        );
      });
    }
  }

  Future<bool> canRunToday() async {
    final now = DateTime.now();
    final today = DateFormat('yyyy-MM-dd').format(now);


    if (state != today) {
      emit(today);
      return true;
    }

    return false;
  }

  @override
  String fromJson(Map<String, dynamic> json) {
    return json['lastRunDate'] ; 
  }

  @override
  Map<String, dynamic> toJson(String state) {
    return {'lastRunDate': state}; 
  }
}
