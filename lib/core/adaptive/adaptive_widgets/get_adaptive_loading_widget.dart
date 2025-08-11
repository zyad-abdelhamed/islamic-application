import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/adaptive/adaptive_widget_depending_on_os.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class GetAdaptiveLoadingWidget extends StatelessWidget {
  const GetAdaptiveLoadingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: adaptiveWidgetDependingOnOs(
          defaultWidget: _getWindowsLoadingWidget(context),
          androidWidget: const CircularProgressIndicator(
            color: AppColors.secondryColor,
          ),
          iosWidget:
              const CupertinoActivityIndicator(color: AppColors.secondryColor),
          windowsWidget: _getWindowsLoadingWidget(context)),
    );
  }
}

Container _getWindowsLoadingWidget(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    color: AppColors.white,
    child: Text(
      AppStrings.translate("loadingText"),
      style: TextStyles.bold20(context).copyWith( color: AppColors.black),
    ),
  );
}
