import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/helper_function/is_land_scape_orintation.dart';
import 'package:test_app/features/app/presentation/controller/controllers/rosary_ring_controller.dart';
import 'package:test_app/features/app/presentation/view/components/common_circle_layout.dart';

class DrawRosaryRingWidget extends StatefulWidget {
  const DrawRosaryRingWidget({super.key});

  @override
  State<DrawRosaryRingWidget> createState() => _DrawRosaryRingWidgetState();
}

class _DrawRosaryRingWidgetState extends State<DrawRosaryRingWidget> {
  late final RosaryRingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = RosaryRingController();
    _controller.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = isLandScapeOrientation(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // المساحة المتاحة جوه الـ dialog
        final double shortestSide = constraints.biggest.shortestSide;
        final double availableSize = shortestSide - 40; // طرح padding

        // حجم الدائرة
        final double targetSize = availableSize * (isLandscape ? 0.45 : 0.55);
        final double safeCircleSize = targetSize.clamp(100.0, 200.0);

        final Wrap wrapWidget = Wrap(
          spacing: 6,
          runSpacing: 6,
          alignment: WrapAlignment.center,
          children: List.generate(
            _controller.tsabeehList.length,
            (index) => ValueListenableBuilder<int>(
              valueListenable: _controller.selectedIndexNotifier,
              builder: (_, selectedIndex, __) => AnimatedContainer(
                duration: AppDurations.mediumDuration,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                  color: _controller.getContainerColor(context, index),
                ),
                child: Text(
                  _controller.tsabeehList[index],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
        );

        final Center circleWidget = Center(
          child: SizedBox(
            width: safeCircleSize,
            height: safeCircleSize,
            child: FittedBox(
              fit: BoxFit.contain,
              child: CommonCircleLayout(
                customPaintSize: safeCircleSize,
                segments: 3,
                maxProgress: 18,
                dashDegree: 6,
                gapDegree: 3.0,
                gapAt: [5, 11, 17],
                progressNotifier: _controller.progressNotifier,
                textBuilder: () => _controller.getRingText,
                onPressed: () => _controller.drawRosaryRing(context),
              ),
            ),
          ),
        );

        return isLandscape
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  circleWidget,
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(8),
                      child: wrapWidget,
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 20,
                children: [
                  circleWidget,
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(8),
                      child: wrapWidget,
                    ),
                  ),
                ],
              );
      },
    );
  }
}
