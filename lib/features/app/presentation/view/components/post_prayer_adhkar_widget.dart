import 'package:flutter/material.dart';
import 'package:test_app/core/utils/extentions/media_query_extention.dart';
import 'package:test_app/features/app/presentation/controller/controllers/post_prayer_adhkar_controller.dart';
import 'package:test_app/features/app/presentation/view/components/common_circle_layout.dart';

class PostPrayerAdhkarWidget extends StatefulWidget {
  const PostPrayerAdhkarWidget({super.key});

  @override
  State<PostPrayerAdhkarWidget> createState() => _PostPrayerAdhkarWidgetState();
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
    return LayoutBuilder(
      builder: (context, constraints) {
        // المساحة المتاحة جوه الـ dialog
        final double shortestSide = constraints.biggest.shortestSide;
        final double availableSize = shortestSide - 40; // طرح padding

        // حجم الدائرة
        final double targetSize =
            availableSize * (context.isLandScape ? 0.45 : 0.55);
        final double safeCircleSize = targetSize.clamp(100.0, 200.0);

        return Center(
          child: SizedBox(
            width: safeCircleSize,
            height: safeCircleSize,
            child: FittedBox(
              fit: BoxFit.contain,
              child: CommonCircleLayout(
                segments: 4,
                customPaintSize: safeCircleSize,
                maxProgress: 104,
                dashDegree: 12,
                gapDegree: 6,
                gapAt: [33, 66, 99, 103],
                progressNotifier: _controller.progressNotifier,
                textBuilder: () => _controller.getText,
                onPressed: () => _controller.drawCircle(context),
              ),
            ),
          ),
        );
      },
    );
  }
}
