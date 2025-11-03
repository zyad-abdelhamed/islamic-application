import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/helper_function/is_dark.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/widgets/share_button.dart';
import 'package:test_app/features/app/data/models/number_animation_model.dart';
import 'package:test_app/features/app/presentation/view/components/copy_button.dart';

class AdhkarWidgetControls extends StatelessWidget {
  const AdhkarWidgetControls({
    super.key,
    required this.content,
    required this.desc,
    required this.countNotifier,
    required this.decreaseCount,
    required this.resetCount,
  });

  final String content;
  final String? desc;
  final ValueNotifier<NumberAnimationModel> countNotifier;
  final void Function() decreaseCount, resetCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: isDark(context) ? Colors.black : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(50.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: resetCount,
                icon: const Icon(
                  Icons.loop,
                  color: AppColors.primaryColor,
                ),
              ),
              CopyButton(
                textToCopy: "$content\n\n\n$desc",
                color: AppColors.primaryColor,
              ),
              ShareButton(
                text: content,
                subject: desc,
                color: AppColors.primaryColor,
              )
            ],
          ),
        ),
        _DecreaseButton(
          decreaseCount: decreaseCount,
          countNotifier: countNotifier,
        ),
      ],
    );
  }
}

class _DecreaseButton extends StatelessWidget {
  const _DecreaseButton({
    required this.decreaseCount,
    required this.countNotifier,
  });

  final void Function() decreaseCount;
  final ValueNotifier<NumberAnimationModel> countNotifier;
  final double size = 60.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: decreaseCount,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withAlpha(127),
                blurRadius: 12,
                spreadRadius: 1,
                offset: Offset(0, 6),
              ),
            ]),
        child: ValueListenableBuilder<NumberAnimationModel>(
          valueListenable: countNotifier,
          builder: (_, NumberAnimationModel model, __) => AnimatedSlide(
            duration: AppDurations.lowDuration,
            offset: model.offset!,
            child: Offstage(
                offstage: model.offStage!,
                child: Text(
                  model.number.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.white,
                      fontFamily: 'normal'),
                )),
          ),
        ),
      ),
    );
  }
}
