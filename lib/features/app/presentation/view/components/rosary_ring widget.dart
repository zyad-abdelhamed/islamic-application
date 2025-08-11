import 'package:flutter/material.dart';
import 'package:test_app/features/app/presentation/controller/controllers/rosary_ring_controller.dart';
import 'package:test_app/features/app/presentation/view/components/common_circle_layout.dart';

class DrawRosaryRingWidget extends StatefulWidget {
  const DrawRosaryRingWidget({
    super.key,
  });

  @override
  State<DrawRosaryRingWidget> createState() => _DrawRosaryRingWidgetState();
}

class _DrawRosaryRingWidgetState extends State<DrawRosaryRingWidget> {
  late final RosaryRingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = RosaryRingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonCircleLayout(
      customPaintSize: 300,
      maxProgress: 3,
      gapAt: [0, 1],
      gapDegree: 5.0,
      notifier: _controller.progressNotifier,
      onPressed: () => _controller.drawRosaryRing(context),
      textBuilder: () => _controller.getRingText,
      progressReader: () => _controller.progressNotifier.value,
    );
  }
}
