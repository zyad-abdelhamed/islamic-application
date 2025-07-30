import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widget_depending_on_os.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';

class GetAdaptiveBackButtonWidget extends StatelessWidget {
  const GetAdaptiveBackButtonWidget({
    super.key,
  });

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
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => _goBack(context),
    );
  }

  Widget _getCupertinoBackButton(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => _goBack(context),
      child: const Icon(CupertinoIcons.back),
    );
  }

  Widget _getWindowsBackButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () => _goBack(context),
      icon: const Icon(Icons.arrow_back, color: AppColors.black),
      label: const Text(
        AppStrings.back,
        style: TextStyle(color: AppColors.black),
      ),
    );
  }

  void _goBack(context) {
    Navigator.pushNamedAndRemoveUntil(
        context, RoutesConstants.homePageRouteName, (route) => false);
  }
}
