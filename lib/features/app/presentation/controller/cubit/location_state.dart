part of 'location_cubit.dart';

 class LocationState extends Equatable {
  const LocationState({this.requestState, this.errorMessage = ''});
  final RequestStateEnum? requestState ;
  final String errorMessage; 

  @override
  List<Object?> get props => [requestState, errorMessage];
}

