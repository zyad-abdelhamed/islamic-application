part of 'reciters_cubit.dart';

sealed class RecitersState extends Equatable {
  const RecitersState();

  @override
  List<Object> get props => [];
}

final class RecitersInitial extends RecitersState {}

final class RecitersFailure extends RecitersState {
  final String message;
  const RecitersFailure(this.message);
}

final class RecitersLoading extends RecitersState {}

final class RecitersLoaded extends RecitersState {
  final List<ReciterEntity> reciters;
  const RecitersLoaded(this.reciters);
}
