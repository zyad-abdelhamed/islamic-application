import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/features/app/data/models/number_animation_model.dart';
import 'package:test_app/features/app/domain/usecases/add_record_use_case.dart';
import 'package:test_app/features/app/domain/usecases/delete_all_records_use_case.dart';
import 'package:test_app/features/app/domain/usecases/delete_records_use_case.dart';
import 'package:test_app/features/app/domain/usecases/get_records_use_case.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';

part 'featured_records_state.dart';

class FeaturedRecordsCubit extends Cubit<FeaturedRecordsState> {
  FeaturedRecordsCubit(this.getRecordsUseCase, this.addRecordUseCase,
      this.deleteAllRecordsUseCase, this.deleteRecordsUseCase)
      : super(const FeaturedRecordsState()) {
    getFeatuerdRecords();
  }

  //variables
  final GetRecordsUseCase getRecordsUseCase;
  final AddRecordUseCase addRecordUseCase;
  final DeleteAllRecordsUseCase deleteAllRecordsUseCase;
  final DeleteRecordsUseCase deleteRecordsUseCase;
  final ScrollController featuredRecordsScrollController = ScrollController();

  static FeaturedRecordsCubit controller(BuildContext context) =>
      context.read<FeaturedRecordsCubit>();

//events
  void getFeatuerdRecords() async {
    Either<Failure, List<int>> result = await getRecordsUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
          featuredRecordsRequestState: RequestStateEnum.failed,
          featuredRecordsErrorMessage: failure.message)),
      (featuredRecords) => emit(state.copyWith(
          featuredRecordsRequestState: RequestStateEnum.success,
          featuredRecords: featuredRecords)),
    );
  }

  void addFeatuerdRecord(
      {required ValueNotifier<NumberAnimationModel> counterNotifier,
      required BuildContext context}) async {
    Either<Failure, Unit> result = await addRecordUseCase(
        parameters: RecordsParameters(
            context: context, item: counterNotifier.value.number));
    result.fold(
      (failure) => appSneakBar(
          context: context, message: failure.message, isError: true),
      (featuredRecords) {
        getFeatuerdRecords();

        if (featuredRecordsScrollController.positions.isNotEmpty) {
          // this check for avoid app crash in case featured records list is empty
          featuredRecordsScrollController.animateTo(
              featuredRecordsScrollController.position.maxScrollExtent + 100,
              duration: AppDurations.mediumDuration,
              curve: Curves.easeInOut);
        }

        counterNotifier.value = NumberAnimationModel(number: 0);

        appSneakBar(
            context: context,
            message: 'تمت الاضافه الي الريكوردات المميزه',
            isError: false);
      },
    );
  }

  void deleteAllFeatuerdRecords(BuildContext context) async {
    Either<Failure, Unit> result = await deleteAllRecordsUseCase();
    result.fold(
      (failure) => appSneakBar(
          context: context, message: failure.message, isError: true),
      (featuredRecords) {
        getFeatuerdRecords();
        emit(state.copyWith());

        appSneakBar(
            context: context,
            message: 'تم حذف جميع الريكوردات المميزه',
            isError: false);
      },
    );
  }

  void deleteFeatuerdRecord(
      {required int id, required BuildContext context}) async {
    Either<Failure, Unit> result = await deleteRecordsUseCase(
        parameters: RecordsParameters(context: context, id: id));
    result.fold(
      (failure) => appSneakBar(
          context: context, message: failure.message, isError: true),
      (featuredRecords) {
        getFeatuerdRecords();
        emit(state.copyWith());

        appSneakBar(
            context: context,
            message: 'تم الحذف من الريكوردات المميزه',
            isError: false);
      },
    );
  }

  @override
  Future<void> close() {
    featuredRecordsScrollController.dispose();
    return super.close();
  }
}
