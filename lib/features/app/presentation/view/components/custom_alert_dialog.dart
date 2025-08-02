import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';

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
    final isDark = ThemeCubit.controller(context).state;
    final backgroundColor = isDark ? AppColors.black : AppColors.white;

    return Dialog(
      backgroundColor: backgroundColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: const BorderSide(
          color: AppColors.secondryColor,
          width: 1.8,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(
                          CupertinoIcons.xmark_circle_fill,
                          color: AppColors.grey,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyles.bold20(context).copyWith(
                            color: AppColors.secondryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      iconWidget(context),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Divider(color: ThemeCubit.controller(context).state ? AppColors.darkModeInActiveColor : AppColors.lightModeInActiveColor),
                  const SizedBox(height: 12),
                  Flexible(
                    child: SingleChildScrollView(
                      child: alertDialogContent(context),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
