import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/controller/controllers/featured_records_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/delete_alert_dialog.dart';

class DeleteAllFeaturedRecordsButton extends StatelessWidget {
  const DeleteAllFeaturedRecordsButton({
    super.key,
    required this.controller,
  });

  final FeaturedRecordsController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: controller.recordsLengthNotifier,
      builder: (_, recordsLength, __) {
        return AnimatedSwitcher(
          duration: AppDurations.lowDuration,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                child: child,
              ),
            );
          },
          child: recordsLength > 1
              ? GestureDetector(
                  key: const ValueKey("deleteAllButton"),
                  onTap: () => showDeleteAlertDialog(
                    context,
                    deleteFunction: () {
                      Navigator.pop(context);
                      FeaturedRecordsCubit.controller(context)
                          .deleteAllFeaturedRecords();
                    },
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      AppStrings.translate("deleteAll"),
                      style: TextStyles.regular14_150(context)
                          .copyWith(color: AppColors.errorColor),
                    ),
                  ),
                )
              : const SizedBox.shrink(), // لما يكون مش ظاهر مش بياخد مساحة
        );
      },
    );
  }
}
