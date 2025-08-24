import 'package:equatable/equatable.dart';
import 'package:test_app/features/app/domain/entities/daily_adhkar_entity.dart';

abstract class DailyAdhkarState extends Equatable {
  const DailyAdhkarState();

  @override
  List<Object?> get props => [];
}

/// initial
class DailyAdhkarInitial extends DailyAdhkarState {}

/// load all
class DailyAdhkarLoading extends DailyAdhkarState {}

class DailyAdhkarLoaded extends DailyAdhkarState {
  final List<DailyAdhkarEntity> adhkar;
  const DailyAdhkarLoaded(this.adhkar);

  @override
  List<Object?> get props => [adhkar];
}

/// add
class DailyAdhkarAdding extends DailyAdhkarState {}

class DailyAdhkarAddSuccess extends DailyAdhkarState {}

/// delete
class DailyAdhkarDeleting extends DailyAdhkarState {}

class DailyAdhkarDeleteSuccess extends DailyAdhkarState {}

class DailyAdhkarError extends DailyAdhkarState {
  final String message;
  const DailyAdhkarError(this.message);

  @override
  List<Object?> get props => [message];
}
