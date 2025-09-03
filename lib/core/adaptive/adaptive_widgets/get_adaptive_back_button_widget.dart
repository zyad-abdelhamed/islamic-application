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
    return OpacityLayout(
      child: GestureDetector(
        child: const Icon(Icons.arrow_back),
        onTap: () => _back(context),
      ),
    );
  }

  Widget _getCupertinoBackButton(BuildContext context) {
    return OpacityLayout(
        child: CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => _back(context),
      child: const Icon(CupertinoIcons.back),
    ));
  }

  Widget _getWindowsBackButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () => _back(context),
      icon: const Icon(Icons.arrow_back, color: AppColors.black),
      label: Text(
        AppStrings.translate("back"),
        style: TextStyle(color: AppColors.black),
      ),
    );
  }

  void _back(context) {
    Navigator.pushNamedAndRemoveUntil(
        context, RoutesConstants.homePageRouteName, (route) => false);
  }
}

class OpacityLayout extends StatelessWidget {
  const OpacityLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (Theme.of(context).brightness == Brightness.dark
                      ? AppColors.white
                      : AppColors.black)
                  .withAlpha(35)),
          child: child,
        ));
  }
}
