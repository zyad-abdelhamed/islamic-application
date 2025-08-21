import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/app/domain/entities/featured_record_entity.dart';
import 'package:test_app/features/app/domain/usecases/add_record_use_case.dart';
import 'package:test_app/features/app/domain/usecases/delete_all_records_use_case.dart';
import 'package:test_app/features/app/domain/usecases/delete_records_use_case.dart';
import 'package:test_app/features/app/domain/usecases/get_records_use_case.dart';


import 'featured_records_state.dart';

class FeaturedRecordsCubit extends Cubit<FeaturedRecordsState> {
  FeaturedRecordsCubit(
    this.getRecordsUseCase,
    this.addRecordUseCase,
    this.deleteAllRecordsUseCase,
    this.deleteRecordsUseCase,
  ) : super(FeaturedRecordsInitial()){
    getFeaturedRecords();
  }

  final GetRecordsUseCase getRecordsUseCase;
  final AddRecordUseCase addRecordUseCase;
  final DeleteAllRecordsUseCase deleteAllRecordsUseCase;
  final DeleteRecordsUseCase deleteRecordsUseCase;

  static FeaturedRecordsCubit controller(context) => BlocProvider.of<FeaturedRecordsCubit>(context);
  void getFeaturedRecords() async {
    emit(FeaturedRecordsLoading());
    Either<Failure, List<FeaturedRecordEntity>> result = await getRecordsUseCase();
    result.fold(
      (failure) => emit(LoadFeaturedRecordsError(failure.message)),
      (records) => emit(FeaturedRecordsLoaded(records)),
    );
  }

  void addFeaturedRecord(int value) async {
  final FeaturedRecordEntity recordEntity = FeaturedRecordEntity(value: value);

  Either<Failure, Unit> result =
      await addRecordUseCase(parameters: RecordsParameters(recordEntity: recordEntity));

  result.fold(
    (failure) => emit(FeaturedRecordsFunctionlityError(failure.message)),
    (_) => emit(
      FeaturedRecordsAddSuccess(
        recordEntity
      ),
    ),
  );
}


  void deleteFeaturedRecord(int index) async {
    Either<Failure, Unit> result =
        await deleteRecordsUseCase(parameters: RecordsParameters(index: index));
    result.fold(
      (failure) => emit(FeaturedRecordsFunctionlityError(failure.message)),
      (_) => emit(FeaturedRecordsDeleteSuccess(index)),
    );
  }

  void deleteAllFeaturedRecords() async {
    Either<Failure, Unit> result = await deleteAllRecordsUseCase();
    result.fold(
      (failure) => emit(FeaturedRecordsFunctionlityError(failure.message)),
      (_) => emit(FeaturedRecordsClearSuccess()),
    );
  }
}
