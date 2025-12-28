import 'package:hydrated_bloc/hydrated_bloc.dart';

class TimeStyleCubit extends HydratedCubit<TimeNumberStyle> {
  TimeStyleCubit() : super(TimeNumberStyle.fingerPaint);

  void changeStyle(TimeNumberStyle style) {
    emit(style);
  }

  @override
  TimeNumberStyle? fromJson(Map<String, dynamic> json) {
    return TimeNumberStyle.values[json['style'] as int];
  }

  @override
  Map<String, dynamic>? toJson(TimeNumberStyle state) {
    return {'style': state.index};
  }
}

enum TimeNumberStyle {
  fingerPaint,
  normal,
  sevenSegment,
}
