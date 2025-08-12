import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';

void showDeleteAlertDialog(BuildContext context,
    {required VoidCallback deleteFunction}) {
  showAdaptiveDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        actionsAlignment: MainAxisAlignment.start,
        title: Text(AppStrings.translate("areYouSure")),
        actions: [
          OutlinedButton(
              onPressed: deleteFunction,
              child: Text(
                AppStrings.translate("yes"),
                style: TextStyles.regular16_120(context,
                    color: AppColors.errorColor),
              )),
          OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppStrings.translate("no"),
                  style: TextStyles.regular16_120(context,
                      color: ThemeCubit.controller(context).state
                          ? AppColors.darkModeTextColor
                          : AppColors.lightModePrimaryColor)))
        ],
      );
    },
  );
}
