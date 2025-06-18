part of 'featured_records_cubit.dart';

class FeaturedRecordsState {
  const FeaturedRecordsState(
      {this.featuredRecordsRequestState = RequestStateEnum.loading,
      this.featuredRecords = const [],
      this.featuredRecordsErrorMessage,
      this.addFeaturedRecordsErrorMessage,
      this.deleteAllFeaturedRecordsErrorMessage});
      
  //get
  final RequestStateEnum featuredRecordsRequestState;
  final List<int> featuredRecords;
  final String? featuredRecordsErrorMessage;
  //add
  final String? addFeaturedRecordsErrorMessage;
  //delete all
  final String? deleteAllFeaturedRecordsErrorMessage;

  FeaturedRecordsState copyWith(
      {RequestStateEnum? featuredRecordsRequestState,
      List<int>? featuredRecords,
      String? featuredRecordsErrorMessage,
      String? addFeaturedRecordsErrorMessage,
      String? deleteAllFeaturedRecordsErrorMessage}) {
    return FeaturedRecordsState(
        featuredRecordsRequestState:
            featuredRecordsRequestState ?? this.featuredRecordsRequestState,
        featuredRecords: featuredRecords ?? this.featuredRecords,
        featuredRecordsErrorMessage:
            featuredRecordsErrorMessage ?? this.featuredRecordsErrorMessage,
        addFeaturedRecordsErrorMessage: addFeaturedRecordsErrorMessage ??
            this.addFeaturedRecordsErrorMessage,
        deleteAllFeaturedRecordsErrorMessage:
            deleteAllFeaturedRecordsErrorMessage ??
                this.deleteAllFeaturedRecordsErrorMessage);
  }
}
