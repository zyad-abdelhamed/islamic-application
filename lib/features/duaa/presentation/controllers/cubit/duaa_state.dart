part of 'duaa_cubit.dart';

class DuaaState {
  const DuaaState(
      {this.duaaErrorMessage = '',
      this.duaaRequestState = RequestStateEnum.loading,
      this.duaas = const []});
  final String duaaErrorMessage;
  final RequestStateEnum duaaRequestState;
  final List<DuaaEntity> duaas;
}
