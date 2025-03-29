part of 'featured_records_cubit.dart';

class FeaturedRecordsState extends Equatable {
  //get
  final RequestStateEnum featuredRecordsRequestState;
  final List<int> featuredRecords;
  final String? featuredRecordsErrorMessage;
  //add
  final RequestStateEnum addFeaturedRecordsRequestState;
  final String? addFeaturedRecordsErrorMessage;
  const FeaturedRecordsState(
      {this.featuredRecordsRequestState = RequestStateEnum.loading,
      this.featuredRecords = const [],
      this.featuredRecordsErrorMessage,
      this.addFeaturedRecordsRequestState = RequestStateEnum.loading,
      this.addFeaturedRecordsErrorMessage});

  @override
  List<Object?> get props => [
        featuredRecordsRequestState,
        featuredRecords,
        featuredRecordsErrorMessage,
        addFeaturedRecordsErrorMessage,
        addFeaturedRecordsRequestState
      ];
}
