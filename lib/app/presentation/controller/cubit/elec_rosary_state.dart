part of 'elec_rosary_cubit.dart';

@immutable
class ElecRosaryState {
  final Offset offset;
  final double opacity;
  final int counter;
  const ElecRosaryState(
      {this.offset = Offset.zero, this.opacity = 1.0, this.counter = 0});
  ElecRosaryState copyWith({
    Offset? offset,
    double? opacity,
    int? counter
  }){
    return ElecRosaryState(
      offset: offset ?? this.offset,
      opacity: opacity ?? this.opacity,
      counter: counter ?? this.counter
    );
  }    
}
