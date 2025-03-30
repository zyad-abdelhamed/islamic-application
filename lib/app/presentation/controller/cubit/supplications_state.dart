part of 'supplications_cubit.dart';

@immutable
class SupplicationsState extends Equatable {
  final Offset offset;
  final double opacity;
  final bool isDeleted;
  final int? index;
  final List<AdhkarEntity> adhkar;
  final RequestStateEnum adhkarRequestState;
  final String? adhkarErorrMessage;

  const SupplicationsState(
      {this.offset = Offset.zero,
      this.opacity = 1.0,
      this.index,
      this.isDeleted = false,
      this.adhkar = const [],
      this.adhkarErorrMessage,
      this.adhkarRequestState = RequestStateEnum.loading});
  SupplicationsState copyWith(
      {Offset? offset,
      double? opacity,
      bool? isDeleted,
      int? index,
      List<AdhkarEntity>? adhkar,
      RequestStateEnum? adhkarRequestState,
      String? adhkarErorrMessage}) {
    return SupplicationsState(
        offset: offset ?? this.offset,
        opacity: opacity ?? this.opacity,
        isDeleted: isDeleted ?? this.isDeleted,
        adhkar: adhkar ?? this.adhkar,
        index: index ?? this.index,
        adhkarRequestState: adhkarRequestState ?? this.adhkarRequestState,
        adhkarErorrMessage: adhkarErorrMessage ?? this.adhkarErorrMessage);
  }

  @override
  List<Object?> get props => [
        offset,
        opacity,
        index,
        isDeleted,
        adhkar,
        adhkarRequestState,
        adhkarErorrMessage
      ];
}
