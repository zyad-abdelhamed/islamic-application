import 'package:test_app/features/app/domain/entities/hifz_plan_entity.dart';

abstract class HifzState {}

class HifzInitial extends HifzState {}

class HifzLoading extends HifzState {}

class HifzLoaded extends HifzState {
  final List<HifzPlanEntity> plans;
  HifzLoaded(this.plans);
}

class HifzActionSuccess extends HifzState {
  final String message;
  HifzActionSuccess(this.message);
}

class HifzError extends HifzState {
  final String message;
  HifzError(this.message);
}
