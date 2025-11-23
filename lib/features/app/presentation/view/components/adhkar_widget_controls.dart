import 'package:flutter/material.dart';
import 'package:test_app/core/constants/constants_values.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/extentions/theme_extention.dart';
import 'package:test_app/core/widgets/share_button.dart';
import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/adhkar_page_controller.dart';
import 'package:test_app/features/app/presentation/view/components/copy_button.dart';
import 'package:test_app/features/app/presentation/view/components/rolling_counter.dart';

class AdhkarWidgetControls extends StatelessWidget {
  const AdhkarWidgetControls({
    super.key,
    required this.adhkarEntity,
    required this.adhkarPageController,
    required this.index,
  });

  final AdhkarEntity adhkarEntity;
  final AdhkarPageController adhkarPageController;
  final int index;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<RollingCounterState> counterKey =
        GlobalKey<RollingCounterState>();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Container(
            width: double.infinity,
            height: 30,
            decoration: BoxDecoration(
              color: context.isDarkMode ? Colors.black : Colors.white,
              borderRadius: const BorderRadius.all(
                  Radius.circular(ConstantsValues.fullCircularRadius)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IconButton(
                  onPressed: () =>
                      counterKey.currentState?.reset(adhkarEntity.count),
                  icon: const Icon(
                    Icons.loop,
                    color: AppColors.teal,
                  ),
                ),
                CopyButton(
                  textToCopy:
                      " ${adhkarEntity.content}\n\n\n${adhkarEntity.description}",
                  color: AppColors.teal,
                ),
                ShareButton(
                  text:
                      " ${adhkarEntity.content}\n\n\n${adhkarEntity.description}",
                  color: AppColors.teal,
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: ConstantsValues.fullCircularRadius / 2,
          top: -10.0,
          child: GestureDetector(
            onTap: () => adhkarPageController.decreaseCount(
                countPrameters: CountPrameters(
                    index: index,
                    counterKey: counterKey,
                    adhkarEntity: adhkarEntity)),
            child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.teal,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.teal.withAlpha(127),
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: RollingCounter(
                key: counterKey,
                initialNumber: adhkarEntity.count,
                textStyle: context.labelLarge.copyWith(
                  fontFamily: 'dataFontFamily',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
