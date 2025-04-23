import 'package:flutter/material.dart';

class OrentationLayout extends StatelessWidget {
  const OrentationLayout({
    super.key,
    required this.landScapeWidget,
    required this.portraitWidget,
  });
  final WidgetBuilder landScapeWidget, portraitWidget;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return landScapeWidget(context);
        }
        return portraitWidget(context);
      },
    );
  }
}
