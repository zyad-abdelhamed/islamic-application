import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/data/models/number_animation_model.dart';
import 'package:test_app/features/app/presentation/view/components/featured_records_widget.dart';

const double counterWidetDefaultMargin =
    showedFeatuerdRecordsWidgetButtonHight + 20;

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    super.key,
    required this.counterNotifier,
    required this.isfeatuerdRecordsWidgetShowedNotifier,
    required this.vibrationNotifier,
  });
  final ValueNotifier<NumberAnimationModel> counterNotifier;
  final ValueNotifier<bool> isfeatuerdRecordsWidgetShowedNotifier;
  final ValueNotifier<bool> vibrationNotifier;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<double> scaleNotifier = ValueNotifier(1.0);

    const double spacing = 15;
    const double resetCircleAvatarRadius = 10;
    return AnimatedPadding(
      duration: AppDurations.longDuration,
      padding: EdgeInsets.symmetric(
          horizontal: _horizontalPadding(context), vertical: 10.0),
      child: AnimatedContainer(
        duration: AppDurations.longDuration,
        margin: EdgeInsets.only(top: _getMargine),
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
                    valueListenable: counterNotifier,
                    builder: (_, __, ___) => AnimatedSlide(
                        duration: AppDurations.lowDuration,
                        offset: counterNotifier.value.offset!,
                        child: AnimatedOpacity(
                          opacity: counterNotifier.value.opacity!,
                          duration: const Duration(seconds: 0),
                          child: Text(
                            counterNotifier.value.number.toString(),
                            style: TextStyles.semiBold32auto(
                              context,
                            ).copyWith(fontFamily: 'normal'),
                          ),
                        )),
                  )),
              SizedBox(height: spacing),
              GestureDetector(
                onTap: resetCounter,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: const CircleAvatar(
                    backgroundColor: AppColors.secondryColor,
                    radius: resetCircleAvatarRadius,
                  ),
                ),
              ),
              GestureDetector(
                onTapDown: (_) =>
                    onTapDown(scaleNotifier: scaleNotifier), // عند الضغط
                onTapUp: (_) =>
                    onTapUp(scaleNotifier: scaleNotifier), // عند رفع الإصبع
                onTapCancel: () =>
                    onTapUp(scaleNotifier: scaleNotifier), // في حالة الإلغاء
                child: ValueListenableBuilder<double>(
                  valueListenable: scaleNotifier,
                  builder: (context, scale, child) {
                    return AnimatedScale(
                      scale: scale,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      child: Container(
                        height: _increaseButtonSize(context),
                        width: _increaseButtonSize(context),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ThemeCubit.controller(context).state
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

  double get _getMargine => isfeatuerdRecordsWidgetShowedNotifier.value
      ? featuerdRecordsWidgetHight + showedFeatuerdRecordsWidgetButtonHight
      : counterWidetDefaultMargin;

  double _horizontalPadding(BuildContext context) {
    return !isfeatuerdRecordsWidgetShowedNotifier.value
        ? 10.0
        : (context.width * 1 / 3) * 1 / 2;
  }

  double _increaseButtonSize(BuildContext context) =>
      !isfeatuerdRecordsWidgetShowedNotifier.value
          ? ((context.width - 20))
          : (context.width * 2 / 3) * .70;

  void increaseCounter() {
    slideAnimation(slideValue: -.7, newValue: counterNotifier.value.number + 1);
  }

  void resetCounter() {
    if (counterNotifier.value.number != 0) {
      slideAnimation(slideValue: .7, newValue: 0);
    }

    return;
  }

  void slideAnimation({required double slideValue, required int newValue}) {
    counterNotifier.value = NumberAnimationModel(
        number: counterNotifier.value.number,
        offset: Offset(0, slideValue),
        opacity: 0.0);
    //start animation

    Future.delayed(AppDurations.lowDuration, () {
      counterNotifier.value = NumberAnimationModel(number: newValue);
    }); //reverse animation and stop
  }

  void onTapDown({required ValueNotifier<double> scaleNotifier}) {
    if (vibrationNotifier.value) {
      HapticFeedback.selectionClick();
    }
    scaleNotifier.value = 0.85;
  }

  void onTapUp({required ValueNotifier<double> scaleNotifier}) {
    if (vibrationNotifier.value) {
      print('vibration');
      HapticFeedback.lightImpact();
    }
    scaleNotifier.value = 1.0;
    increaseCounter();
  }
}
