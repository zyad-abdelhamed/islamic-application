import 'package:flutter/material.dart';
import 'package:test_app/features/app/presentation/view/components/erorr_widget.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/utils/enums.dart';

Widget getWidgetDependingOnReuestState(
    {required RequestStateEnum requestStateEnum,
    required Widget widgetIncaseSuccess,
    required String? erorrMessage}) {
  switch (requestStateEnum) {
    case RequestStateEnum.success:
      return widgetIncaseSuccess;
    case RequestStateEnum.failed:
      return ErorrWidget(message: erorrMessage!);
    case RequestStateEnum.loading:
      return GetAdaptiveLoadingWidget();
  }
}
