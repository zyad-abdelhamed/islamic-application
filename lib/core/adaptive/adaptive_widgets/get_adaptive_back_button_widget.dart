import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widget_depending_on_os.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';

enum BackBehavior { pop, backToHomeBage }

class GetAdaptiveBackButtonWidget extends StatelessWidget {
  const GetAdaptiveBackButtonWidget({
    super.key,
    this.backBehavior = BackBehavior.backToHomeBage,
  });

  final BackBehavior backBehavior;

  @override
  Widget build(BuildContext context) {
    return adaptiveWidgetDependingOnOs(
      defaultWidget: _getDefaultBackButton(context),
      androidWidget: _getDefaultBackButton(context),
      iosWidget: _getCupertinoBackButton(context),
      windowsWidget: _getWindowsBackButton(context),
    );
  }

  Widget _getDefaultBackButton(BuildContext context) {
    return GestureDetector(
      child: const Icon(
        Icons.arrow_back,
        color: AppColors.primaryColor,
      ),
      onTap: () => _back(context, backBehavior),
    );
  }

  Widget _getCupertinoBackButton(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => _back(context, backBehavior),
      child: const Icon(
        CupertinoIcons.back,
        color: AppColors.primaryColor,
      ),
    );
  }

  Widget _getWindowsBackButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () => _back(context, backBehavior),
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      label: Text(
        AppStrings.translate("back"),
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  void _back(BuildContext context, BackBehavior backBehavior) {
    switch (backBehavior) {
      case BackBehavior.pop:
        Navigator.maybePop(context);
      case BackBehavior.backToHomeBage:
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesConstants.homePageRouteName, (route) => false);
    }
  }
}
