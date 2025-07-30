part of 'location_cubit.dart';

 class LocationState extends Equatable {
  const LocationState({this.updateRequestState, this.errorMessage = ''});
  final RequestStateEnum? updateRequestState ;
  final String errorMessage; 

  @override
  List<Object> get props => [];
}

