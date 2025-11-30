import 'package:flutter/material.dart';

extension MediaQueryExtention on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  bool get isLandScape =>
      MediaQuery.of(this).orientation == Orientation.landscape;
  bool get isPotrait => MediaQuery.of(this).orientation == Orientation.portrait;
  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get bottomPadding => MediaQuery.of(this).padding.bottom;
  double get safeHeight => height - statusBarHeight - bottomPadding;
  double get safeWidth => width;
}
