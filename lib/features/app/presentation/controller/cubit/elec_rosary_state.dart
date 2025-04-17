part of 'elec_rosary_cubit.dart';

@immutable
class ElecRosaryState {
  final Offset offset;
  final double opacity;
  const ElecRosaryState(
      {this.offset = Offset.zero, this.opacity = 1.0});
  ElecRosaryState copyWith({
    Offset? offset,
    double? opacity,
  }){
    return ElecRosaryState(
      offset: offset ?? this.offset,
      opacity: opacity ?? this.opacity,
    );
  }    
}
