import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/extentions/media_query_extention.dart';
import 'package:test_app/core/widgets/app_divider.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.alertDialogContent,
    required this.iconWidget,
  });

  final String title;
  final WidgetBuilder alertDialogContent;
  final WidgetBuilder iconWidget;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).cardColor,
      insetPadding: context.isLandScape
          ? const EdgeInsets.all(8.0)
          : const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 8,
      shadowColor: AppColors.grey.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ====== Header ======
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    CupertinoIcons.xmark_circle_fill,
                    color: AppColors.grey,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyles.bold20(context).copyWith(
                      color: AppColors.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                iconWidget(context),
              ],
            ),

            const SizedBox(height: 16),
            const AppDivider(),
            const SizedBox(height: 16),

            // ====== Content ======
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: alertDialogContent(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
