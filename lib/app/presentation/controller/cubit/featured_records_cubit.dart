import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app/domain/usecases/add_record_use_case.dart';
import 'package:test_app/app/domain/usecases/delete_all_records_use_case.dart';
import 'package:test_app/app/domain/usecases/delete_records_use_case.dart';
import 'package:test_app/app/domain/usecases/get_records_use_case.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/utils/enums.dart';

part 'featured_records_state.dart';

class FeaturedRecordsCubit extends Cubit<FeaturedRecordsState> {
  final GetRecordsUseCase getRecordsUseCase;
  final AddRecordUseCase addRecordUseCase;
  final DeleteAllRecordsUseCase deleteAllRecordsUseCase;
  final DeleteRecordsUseCase deleteRecordsUseCase;
  FeaturedRecordsCubit(this.getRecordsUseCase, this.addRecordUseCase,
      this.deleteAllRecordsUseCase, this.deleteRecordsUseCase)
      : super(const FeaturedRecordsState());

  static FeaturedRecordsCubit getFeatuerdRecordsController(
      BuildContext context) {
    final FeaturedRecordsCubit controller =
        context.read<FeaturedRecordsCubit>();
    return controller;
  }

  void getFeatuerdRecords() async {
    Either<Failure, List<int>> result = await getRecordsUseCase();
    result.fold(
      (failure) {
        print(failure.message);
        emit(FeaturedRecordsState(
            featuredRecordsRequestState: RequestStateEnum.failed,
            featuredRecordsErrorMessage: failure.message));
      },
      (featuredRecords) => emit(FeaturedRecordsState(
          featuredRecordsRequestState: RequestStateEnum.success,
          featuredRecords: featuredRecords)),
    );
  }

  void addFeatuerdRecord({required int item}) async {
    Either<Failure, Unit> result =
        await addRecordUseCase(parameters: RecordsParameters(item: item));
    result.fold(
      (failure) {
        print(failure.message);

        emit(FeaturedRecordsState(
            featuredRecordsRequestState: RequestStateEnum.failed,
            featuredRecordsErrorMessage: failure.message));
      },
      (featuredRecords) {
        print('success');
        emit(FeaturedRecordsState(
          featuredRecordsRequestState: RequestStateEnum.success,
        ));
      },
    );

    // getFeatuerdRecords();
  }
}
