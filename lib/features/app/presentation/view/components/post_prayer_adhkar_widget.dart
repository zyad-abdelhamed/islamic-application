import 'package:flutter/material.dart';
import 'package:test_app/features/app/presentation/controller/controllers/post_prayer_adhkar_controller.dart';
import 'package:test_app/features/app/presentation/view/components/common_circle_layout.dart';

class DrawCircleProgressWidget extends StatefulWidget {
  const DrawCircleProgressWidget({
    super.key,
  });

  @override
  State<DrawCircleProgressWidget> createState() =>
      _DrawCircleProgressWidgetState();
}

class _DrawCircleProgressWidgetState extends State<DrawCircleProgressWidget> {
  late final PostPrayerAdhkarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PostPrayerAdhkarController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonCircleLayout(
      customPaintSize: 100,
      maxProgress: 100,
      gapAt: [33, 66, 99],
      gapDegree: 30,
      notifier: _controller.notifier,
      onPressed: () => _controller.drawCircle(context),
      textBuilder: () => _controller.getText,
      progressReader: () => _controller.progress,
    );
  }
}
