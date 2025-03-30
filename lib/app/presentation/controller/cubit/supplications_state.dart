part of 'supplications_cubit.dart';

@immutable
class SupplicationsState extends Equatable {
  final Offset offset;
  final double opacity;
  final List<AdhkarEntity> adhkar;
  final RequestStateEnum adhkarRequestState;
  final String? adhkarErorrMessage;

  const SupplicationsState(
      {this.offset = Offset.zero,
      this.opacity = 1.0,
      this.adhkar = const [],
      this.adhkarErorrMessage,
      this.adhkarRequestState = RequestStateEnum.loading});
  SupplicationsState copyWith(
      {Offset? offset,
      double? opacity,
      List<AdhkarEntity>? adhkar,
      RequestStateEnum? adhkarRequestState,
      String? adhkarErorrMessage}) {
    return SupplicationsState(
        offset: offset ?? this.offset,
        opacity: opacity ?? this.opacity,
        adhkar: adhkar ?? this.adhkar,
        adhkarRequestState: adhkarRequestState ?? this.adhkarRequestState,
        adhkarErorrMessage: adhkarErorrMessage ?? this.adhkarErorrMessage);
  }

  @override
  List<Object?> get props =>
      [offset, opacity, adhkar, adhkarRequestState, adhkarErorrMessage];
}
