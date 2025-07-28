import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  const LocationEntity({required this.latitude, required this.longitude, required this.name});

  final double latitude, longitude;
  final String name;
 
  @override
  List<Object?> get props => [latitude, longitude, name];
}
