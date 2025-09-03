import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/data/models/number_animation_model.dart';
import 'package:test_app/features/app/presentation/controller/controllers/counter_controller.dart';
import 'package:test_app/features/app/presentation/view/components/featured_records_widget.dart';

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
          horizontal: controller.horizontalPadding(context), vertical: 10.0),
      child: AnimatedContainer(
        duration: AppDurations.longDuration,
        margin: EdgeInsets.only(top: controller.getMargine),
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
                        width: 3, color: Theme.of(context).primaryColor),
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                  ),
                  child: ValueListenableBuilder<NumberAnimationModel>(
                    valueListenable: controller.counterNotifier,
                    builder: (_, __, ___) => AnimatedSlide(
                        duration: AppDurations.lowDuration,
                        offset: controller.counterNotifier.value.offset!,
                        child: Offstage(
                          offstage: controller.counterNotifier.value.offStage!,
                          child: Text(
                            controller.counterNotifier.value.number.toString(),
                            style: TextStyles.semiBold32auto(
                              context,
                            ).copyWith(fontFamily: 'normal'),
                          ),
                        )),
                  )),
              SizedBox(height: spacing),
              resetButton,
              GestureDetector(
                onTapDown: (_) => controller.onTapDown(
                    scaleNotifier: controller.scaleNotifier), // عند الضغط
                onTapUp: (_) => controller.onTapUp(
                    scaleNotifier: controller.scaleNotifier), // عند رفع الإصبع
                onTapCancel: () => controller.onTapUp(
                    scaleNotifier: controller.scaleNotifier), // في حالة الإلغاء
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
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.darkModeInActiveColor
                              : AppColors.lightModeInActiveColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]),
      ),
    );
  }
}
