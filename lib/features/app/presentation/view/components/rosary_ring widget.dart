import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/constants/app_strings.dart';
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
    return Column(
      spacing: 20,
      children: [
        Wrap(
          spacing: 5,
          runSpacing: 5,
          children: List.generate(
            AppStrings.translate("adhkarList").length,
            (index) => AnimatedContainer(
          duration: AppDurations.mediumDuration,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(color: Theme.of(context).primaryColor, width: 3),
              color: _controller.getContainerColor(context, index)),
          child: Text(
            AppStrings.translate("adhkarList")[index],
          ),
        ),
          ),
        ),
        CommonCircleLayout(
          customPaintSize: 200,
          segments: 3,
          maxProgress: 4,
          dashDegree: 12,
          gapDegree: 6.0,
          gapAt: [1, 2],
          progressNotifier: _controller.progressNotifier,
          textNotifier: ValueNotifier(''),
          onPressed: () => _controller.drawRosaryRing(context),
        ),
      ],
    );
  }
}
