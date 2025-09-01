part of 'reset_app_cubit.dart';

sealed class ResetAppState extends Equatable {
  const ResetAppState();

  @override
  List<Object> get props => [];
}

final class ResetAppInitial extends ResetAppState {}

final class ResetAppLoading extends ResetAppState {}

final class ResetAppError extends ResetAppState {
  final String message;
  const ResetAppError(this.message);

  @override
  List<Object> get props => [message];
}

final class ResetAppSuccess extends ResetAppState {}
