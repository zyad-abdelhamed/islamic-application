part of 'adhkar_cubit.dart';

@immutable
class AdhkarState {
  final double progress;
  final int? selectedIndex;
  final List<Offset>? adhkarWidgetsOffsets;
  final List<bool>? adhkarWidgetsMaintainingSize;
  final bool isDeleted;
  final List<AdhkarEntity> adhkar;
  final List<int> adhkarcounts;
  final RequestStateEnum adhkarRequestState;
  final String? adhkarErorrMessage;

  const AdhkarState(
      {this.progress = 0.0,
      this.selectedIndex,
      this.adhkarWidgetsOffsets,
      this.adhkarWidgetsMaintainingSize,
      this.isDeleted = true,
      this.adhkar = const [],
      this.adhkarcounts = const [],
      this.adhkarErorrMessage,
      this.adhkarRequestState = RequestStateEnum.loading});

  AdhkarState copyWith(
      {double? progress,
      int? selectedIndexOfChildAnimation,
      List<Offset>? adhkarWidgetsOffsets,
      List<bool>? adhkarWidgetsMaintainingSize,
      bool? isDeleted,
      List<AdhkarEntity>? adhkar,
      List<int>? adhkarcounts,
      RequestStateEnum? adhkarRequestState,
      String? adhkarErorrMessage}) {
    return AdhkarState(
        progress: progress ?? this.progress,
        isDeleted: isDeleted ?? this.isDeleted,
        adhkar: adhkar ?? this.adhkar,
        adhkarcounts: adhkarcounts ?? this.adhkarcounts,
        selectedIndex:
            selectedIndexOfChildAnimation ?? this.selectedIndex,
        adhkarWidgetsOffsets: adhkarWidgetsOffsets ?? this.adhkarWidgetsOffsets,
        adhkarWidgetsMaintainingSize:
            adhkarWidgetsMaintainingSize ?? this.adhkarWidgetsMaintainingSize,
        adhkarRequestState: adhkarRequestState ?? this.adhkarRequestState,
        adhkarErorrMessage: adhkarErorrMessage ?? this.adhkarErorrMessage);
  }
}
