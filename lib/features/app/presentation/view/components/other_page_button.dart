import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/view/components/custom_alert_dialog.dart';

class OtherPageButton extends StatelessWidget {
  const OtherPageButton({
    super.key,
    required this.text,
    required this.alertDialogContent,
    required this.logo
  });

  final String text;
  final Widget alertDialogContent;
  final Widget logo;

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeCubit.controller(context).state;

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => CustomAlertDialog(
            title: text,
            alertDialogContent: (_) => alertDialogContent,
            iconWidget: (_) => logo,
          ),
        );
      },
      child: Chip(
          label: Text(
        text,
        style: TextStyles.semiBold20(context).copyWith(
          color: isDark
              ? AppColors.darkModeTextColor
              : AppColors.lightModeTextColor,
          height: 1.2,
        ),
      )),
    );
  }
}
