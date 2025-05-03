part of 'rtabel_cubit.dart';

class RtabelState extends Equatable {
  final List<bool> checkBoxsValues;
  final RequestStateEnum requestState;
  final String errorMessage;

  const RtabelState({
    this.checkBoxsValues = const [],
    this.requestState = RequestStateEnum.loading,
    this.errorMessage = '',
  });

  RtabelState copyWith({
    List<bool>? checkBoxsValues,
    RequestStateEnum? requestState,
    String? errorMessage,
  }) {
    return RtabelState(
      checkBoxsValues: checkBoxsValues ?? this.checkBoxsValues,
      requestState: requestState ?? this.requestState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [checkBoxsValues, requestState, errorMessage];
}
