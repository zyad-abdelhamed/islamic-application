import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/extentions/media_query_extention.dart';
import 'package:test_app/core/utils/extentions/theme_extention.dart';
import 'package:test_app/features/app/presentation/controller/controllers/counter_controller.dart';
import 'package:test_app/features/app/presentation/view/components/featured_records_widget.dart';
import 'package:test_app/features/app/presentation/view/components/rolling_counter.dart';

const double counterWidetDefaultMargin =
    showedFeatuerdRecordsWidgetButtonHight + 20;

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    super.key,
    required this.controller,
    required this.resetButton,
  });

  final CounterController controller;
  final Widget resetButton;

  @override
  Widget build(BuildContext context) {
    const double spacing = 15;

    return AnimatedPadding(
      duration: AppDurations.longDuration,
      padding: EdgeInsets.symmetric(
        horizontal: controller.horizontalPadding(context),
        vertical: 10.0,
      ),
      child: AnimatedContainer(
        duration: AppDurations.longDuration,
        margin: context.isLandScape
            ? const EdgeInsets.all(0.0)
            : EdgeInsets.only(top: controller.getMargine),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(18)),
              ),
              child: RollingCounter(
                key: controller.counterKey,
                initialNumber: 0,
                textStyle: context.displayLarge.copyWith(
                  fontFamily: 'normal',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: spacing),
            resetButton,
            GestureDetector(
              onTapDown: (_) => controller.onTapDown(),
              onTapUp: (_) => controller.onTapUp(),
              onTapCancel: () => controller.onTapUp(),
              child: ValueListenableBuilder<double>(
                valueListenable: controller.scaleNotifier,
                builder: (context, scale, child) {
                  return AnimatedScale(
                    scale: scale,
                    duration: AppDurations.lowDuration,
                    curve: Curves.easeOut,
                    child: AnimatedContainer(
                      duration: AppDurations.longDuration,
                      height: controller.increaseButtonSize(context),
                      width: controller.increaseButtonSize(context),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColorInActiveColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
