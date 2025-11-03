import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';
import 'package:test_app/features/app/presentation/controller/cubit/hifz_state.dart';
import '../../../domain/entities/hifz_plan_entity.dart';
import '../../../domain/entities/surah_prograss_entity.dart';

class HifzCubit extends Cubit<HifzState> {
  final BaseQuranRepo baseQuranRepo;

  HifzCubit(this.baseQuranRepo) : super(HifzInitial());

  // تحميل كل الخطط
  Future<void> loadPlans() async {
    emit(HifzLoading());
    final result = await baseQuranRepo.getAllPlans();

    result.fold(
      (failure) => emit(HifzError(failure.message)),
      (data) {
        emit(HifzLoaded(data));
      },
    );
  }

  // إضافة خطة جديدة
  Future<void> addPlan(String planName) async {
    final HifzPlanEntity newPlan = HifzPlanEntity(
      planName: planName,
      createdAt: DateTime.now(),
      lastProgress: "",
      surahsProgress: const {},
    );

    final result = await baseQuranRepo.addPlan(newPlan);

    result.fold(
      (failure) => emit(HifzError(failure.message)),
      (_) {
        emit(HifzActionSuccess("تمت اضافة الخطة بنجاح"));
      },
    );
  }

  // إضافة/تحديث سورة داخل خطة
  Future<void> upsertSurahProgress(
      String planName, SurahProgressEntity surah) async {
    final result = await baseQuranRepo.upsertSurahProgress(
      planName: planName,
      surahProgress: surah,
    );

    result.fold(
      (failure) => emit(HifzError(failure.message)),
      (_) async {
        await loadPlans();
        emit(HifzActionSuccess("تم تعديل الخطة بنجاح"));
      },
    );
  }

  // حذف خطط متعددة
  Future<void> deletePlans(List<String> planNames) async {
    final result = await baseQuranRepo.deleteMultiplePlans(planNames);

    result.fold(
      (failure) => emit(HifzError(failure.message)),
      (_) async {
        emit(HifzActionSuccess("تم حذف الخطط بنجاح"));
      },
    );
  }
}
