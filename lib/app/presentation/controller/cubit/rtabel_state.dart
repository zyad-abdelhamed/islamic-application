part of 'rtabel_cubit.dart';

@immutable
class RtabelState extends Equatable {
  const RtabelState(
      {this.checkBoxsValues = const [],
      this.errorMessage,
      this.requestState = RequestStateEnum.loading});

  final List<bool> checkBoxsValues;
  final String? errorMessage;
  final RequestStateEnum requestState;

  @override
  List<Object?> get props => [checkBoxsValues, errorMessage, requestState];
}
