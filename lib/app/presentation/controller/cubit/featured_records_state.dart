part of 'featured_records_cubit.dart';

class FeaturedRecordsState extends Equatable {
    final double progress;

  final int dummyCounterState;
  //get
  final RequestStateEnum featuredRecordsRequestState;
  final List<int> featuredRecords;
  final String? featuredRecordsErrorMessage;
  //add
  final String? addFeaturedRecordsErrorMessage;
  //delete all
  final String? deleteAllFeaturedRecordsErrorMessage;
  const FeaturedRecordsState(
      {this.progress = 0.0,
        this.dummyCounterState = 0,
      this.featuredRecordsRequestState = RequestStateEnum.loading,
      this.featuredRecords = const [],
      this.featuredRecordsErrorMessage,
      this.addFeaturedRecordsErrorMessage,
      this.deleteAllFeaturedRecordsErrorMessage});

  FeaturedRecordsState copyWith(
      {double? progress,
        int? dummyCounterState,
      RequestStateEnum? featuredRecordsRequestState,
      List<int>? featuredRecords,
      String? featuredRecordsErrorMessage,
      String? addFeaturedRecordsErrorMessage,
      String? deleteAllFeaturedRecordsErrorMessage}) {
    return FeaturedRecordsState(
      progress: progress ?? this.progress,
        dummyCounterState: dummyCounterState ?? this.dummyCounterState,
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

  @override
  List<Object?> get props => [
    progress,
        dummyCounterState,
        featuredRecordsRequestState,
        featuredRecords,
        featuredRecordsErrorMessage,
        addFeaturedRecordsErrorMessage,
        deleteAllFeaturedRecordsErrorMessage
      ];
}
