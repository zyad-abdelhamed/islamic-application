part of 'featured_records_cubit.dart';

class FeaturedRecordsState extends Equatable {
  //get
  final RequestStateEnum featuredRecordsRequestState;
  final List<int> featuredRecords;
  final String? featuredRecordsErrorMessage;
  //add
  final RequestStateEnum? addFeaturedRecordsRequestState;
  final String? addFeaturedRecordsErrorMessage;
  //delete all
  final RequestStateEnum? deleteAllFeaturedRecordsRequestState;
  final String? deleteAllFeaturedRecordsErrorMessage;
  const FeaturedRecordsState(
      {this.featuredRecordsRequestState = RequestStateEnum.loading,
      this.featuredRecords = const [],
      this.featuredRecordsErrorMessage,
      this.addFeaturedRecordsRequestState,
      this.addFeaturedRecordsErrorMessage,
      this.deleteAllFeaturedRecordsRequestState,
      this.deleteAllFeaturedRecordsErrorMessage});
  @override
  List<Object?> get props => [
        featuredRecordsRequestState,
        featuredRecords,
        featuredRecordsErrorMessage,
        addFeaturedRecordsErrorMessage,
        addFeaturedRecordsRequestState,
        deleteAllFeaturedRecordsRequestState,
        deleteAllFeaturedRecordsErrorMessage
      ];
}
