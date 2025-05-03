part of 'qibla_cubit.dart';

abstract class QiblaState {}

class QiblaInitial extends QiblaState {}

class QiblaLoading extends QiblaState {}

class QiblaLoaded extends QiblaState {
  final double deviceDirection;
  final double qiblaDirection;

  QiblaLoaded({required this.deviceDirection, required this.qiblaDirection});
}

class QiblaError extends QiblaState {
  final String message;
  QiblaError(this.message);
}
