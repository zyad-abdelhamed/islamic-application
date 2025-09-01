import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/presentation/view/components/custom_alert_dialog.dart';

void showLocationWarningDialog(
    BuildContext context, bool isDeniedLocationPermission) {
  showDialog(
    context: context,
    builder: (context) => CustomAlertDialog(
      title: 'تنبيه هام',
      alertDialogContent: (context) => Column(
        children: [
          Text(
            isDeniedLocationPermission
                ? AppStrings.translate(
                    "deniedLocationPermissionAlertDialogText")
                : AppStrings.translate("notLocationSaved"),
            textAlign: TextAlign.right,
            style: const TextStyle(height: 1.5, fontFamily: 'dataFontFamily'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesConstants.splashScreenRouteName,
                (_) => false,
              );
            },
            child: Text(AppStrings.translate("gotIt")),
          )
        ],
      ),
      iconWidget: (BuildContext context) => const Icon(
        Icons.warning,
        color: AppColors.secondryColor,
      ),
    ),
  );
}
