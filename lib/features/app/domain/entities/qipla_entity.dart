class QiblaEntity {
  /// اتجاه الجهاز الحالي بالبوصلة
  final double deviceDirection;

  /// اتجاه القبلة بالنسبة للشمال
  final double qiblaDirection;

  const QiblaEntity({
    required this.deviceDirection,
    required this.qiblaDirection,
  });

  QiblaEntity copyWith({
    double? deviceDirection,
    double? qiblaDirection,
  }) {
    return QiblaEntity(
      deviceDirection: deviceDirection ?? this.deviceDirection,
      qiblaDirection: qiblaDirection ?? this.qiblaDirection,
    );
  }
}
