part of 'supplications_cubit.dart';

@immutable
class SupplicationsState extends Equatable {
  final double progress;
  final int? selectedIndexOfChildAnimation;
  final List<Offset>? adhkarWidgetsOffsets;
  final List<bool>? adhkarWidgetsMaintainingSize;
  final int dummyCounterState;
  final bool isDeleted;
  final List<AdhkarEntity> adhkar;
  final List<int> adhkarcounts;
  final RequestStateEnum adhkarRequestState;
  final String? adhkarErorrMessage;

  const SupplicationsState(
      {this.progress = 0.0,
      this.selectedIndexOfChildAnimation,
      this.adhkarWidgetsOffsets,
      this.adhkarWidgetsMaintainingSize,
      this.dummyCounterState = 0,
      this.isDeleted = false,
      this.adhkar = const [],
      this.adhkarcounts = const [],
      this.adhkarErorrMessage,
      this.adhkarRequestState = RequestStateEnum.loading});

  SupplicationsState copyWith(
      {double? progress,
      int? selectedIndexOfChildAnimation,
      List<Offset>? adhkarWidgetsOffsets,
      List<bool>? adhkarWidgetsMaintainingSize,
      int? selectedIndexOfVisibilty,
      bool? isDeleted,
      List<AdhkarEntity>? adhkar,
      List<int>? adhkarcounts,
      RequestStateEnum? adhkarRequestState,
      String? adhkarErorrMessage}) {
    return SupplicationsState(
        progress: progress ?? this.progress,
        isDeleted: isDeleted ?? this.isDeleted,
        adhkar: adhkar ?? this.adhkar,
        adhkarcounts: adhkarcounts ?? this.adhkarcounts,
        selectedIndexOfChildAnimation:
            selectedIndexOfChildAnimation ?? this.selectedIndexOfChildAnimation,
        adhkarWidgetsOffsets: adhkarWidgetsOffsets ?? this.adhkarWidgetsOffsets,
        adhkarWidgetsMaintainingSize:
            adhkarWidgetsMaintainingSize ?? this.adhkarWidgetsMaintainingSize,
        dummyCounterState:
            selectedIndexOfVisibilty ?? this.dummyCounterState,
        adhkarRequestState: adhkarRequestState ?? this.adhkarRequestState,
        adhkarErorrMessage: adhkarErorrMessage ?? this.adhkarErorrMessage);
  }

  @override
  List<Object?> get props => <dynamic>[
        progress,
        selectedIndexOfChildAnimation,
        adhkarWidgetsOffsets,
        adhkarWidgetsMaintainingSize,
        dummyCounterState,
        isDeleted,
        adhkar,
        adhkarcounts,
        adhkarRequestState,
        adhkarErorrMessage
      ];
}
