part of 'duaa_cubit.dart';

class DuaaState extends Equatable {
  const DuaaState(
      {this.duaaErrorMessage = '',
      this.duaaRequestState = RequestStateEnum.loading,
      this.duaas = const []});
  final String duaaErrorMessage;
  final RequestStateEnum duaaRequestState;
  final List<DuaaEntity> duaas;
  @override
  List<Object> get props => [duaaErrorMessage, duaaRequestState, duaas];
}
