import 'package:flutter/material.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/presentation/controller/controllers/post_prayer_adhkar_controller.dart';
import 'package:test_app/features/app/presentation/view/components/common_circle_layout.dart';

class PostPrayerAdhkarWidget extends StatefulWidget {
  const PostPrayerAdhkarWidget({
    super.key,
  });

  @override
  State<PostPrayerAdhkarWidget> createState() =>
      _PostPrayerAdhkarWidgetState();
}

class _PostPrayerAdhkarWidgetState extends State<PostPrayerAdhkarWidget> {
  late final PostPrayerAdhkarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PostPrayerAdhkarController();
    _controller.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: CommonCircleLayout(
        segments: 4,
        customPaintSize: context.width * 0.60,
        maxProgress: 104,
        dashDegree: 12,
        gapDegree: 6,
        gapAt: [33, 66, 99,103],
        progressNotifier: _controller.progressNotifier,
        textNotifier: _controller.text,
        onPressed: () => _controller.drawCircle(context)
      ),
    );
  }
}
