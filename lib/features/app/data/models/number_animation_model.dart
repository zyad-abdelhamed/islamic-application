import 'dart:ui';

class NumberAnimationModel {
  int number;
  final Offset? offset;
  final double? opacity;

  NumberAnimationModel(
      {required this.number, this.offset = Offset.zero, this.opacity = 1.0});
}
