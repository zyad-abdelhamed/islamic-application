import 'package:test_app/features/app/domain/entities/featured_record_entity.dart';
abstract class FeaturedRecordsState {
  const FeaturedRecordsState();
}

class FeaturedRecordsInitial extends FeaturedRecordsState {}

class FeaturedRecordsLoading extends FeaturedRecordsState {}

class FeaturedRecordsLoaded extends FeaturedRecordsState {
  final List<FeaturedRecordEntity> featuredRecords;
  const FeaturedRecordsLoaded(this.featuredRecords);
}

class LoadFeaturedRecordsError extends FeaturedRecordsState {
  final String message;
  const LoadFeaturedRecordsError(this.message);
}

class FeaturedRecordsAddSuccess extends FeaturedRecordsState {
  final FeaturedRecordEntity newRecord;
  const FeaturedRecordsAddSuccess(this.newRecord);
}

class FeaturedRecordsDeleteSuccess extends FeaturedRecordsState {
  final int deletedIndex;
  const FeaturedRecordsDeleteSuccess(this.deletedIndex);
}

class FeaturedRecordsClearSuccess extends FeaturedRecordsState {}

class FeaturedRecordsFunctionlityError extends FeaturedRecordsState {
  final String message;
  const FeaturedRecordsFunctionlityError(this.message);
}
