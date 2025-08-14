part of 'qibla_cubit.dart';

abstract class QiblaState {}

class QiblaInitial extends QiblaState {}

class QiblaLoading extends QiblaState {}

class QiblaLoaded extends QiblaState {
  final QiblaEntity qibla;
  final LocationAccuracy accuracy;
  QiblaLoaded(this.qibla, this.accuracy);
}

class QiblaError extends QiblaState {
  final String message;
  QiblaError(this.message);
}
