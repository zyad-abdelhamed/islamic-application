import 'dart:io';

import 'package:flutter/material.dart';

Widget adaptiveWidgetDependingOnOs(
    {required Widget defaultWidget,
    required Widget androidWidget,
    required Widget iosWidget,
    Widget? windowsWidget}) {
  if (Platform.isAndroid) {
    return androidWidget;
  } else if (Platform.isIOS) {
    return iosWidget;
  } else if (Platform.isWindows) {
    return windowsWidget ?? defaultWidget;
  }
  return defaultWidget;
}
