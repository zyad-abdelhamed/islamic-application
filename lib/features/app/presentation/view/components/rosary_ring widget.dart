import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
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
    _controller.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        Wrap(
          spacing: 5,
          runSpacing: 5,
          children: List.generate(
            _controller.tsabeehList.length,
            (index) => ValueListenableBuilder<int>(
              valueListenable: _controller.selectedIndexNotifier,
              builder: (_, selectedIndex, __) => AnimatedContainer(
                duration: AppDurations.mediumDuration,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 3),
                    color: _controller.getContainerColor(context, index)),
                child: Text(
                  _controller.tsabeehList[index],
                ),
              ),
            ),
          ),
        ),
        CommonCircleLayout(
          customPaintSize: 200,
          segments: 3,
          maxProgress: 18,
          dashDegree: 6,
          gapDegree: 3.0,
          gapAt: [5, 11, 17],
          progressNotifier: _controller.progressNotifier,
          textBuilder: () => _controller.getRingText,
          onPressed: () => _controller.drawRosaryRing(context),
        ),
      ],
    );
  }
}
