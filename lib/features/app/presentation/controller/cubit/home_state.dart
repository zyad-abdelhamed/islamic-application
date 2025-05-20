part of 'home_cubit.dart';

class HomeState extends Equatable {
  final double width;
  final bool isVisible;
  final double opacity;

  const HomeState({
    this.opacity = 0.0,
    this.width = 0.0,
    this.isVisible = false,
  });

  HomeState copyWith({
    double? width,
    double? opacity,
    bool? isVisible,
  }) {
    return HomeState(
      width: width ?? this.width,
      opacity: opacity ?? this.opacity,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  List<Object?> get props => [
        opacity,
        width,
        isVisible,
      ];
}
