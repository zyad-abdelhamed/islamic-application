
import 'package:flutter/cupertino.dart';

double getResponsiveFontSize(
    {required BuildContext context, required double fontSize}) {
  double scaleFactor = getScaleFactor(context: context);
  double responsiveFontSize = fontSize * scaleFactor;
  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;
  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor({required BuildContext context}) {
  if (MediaQuery.of(context).size.width < 600) {
    return MediaQuery.of(context).size.width / 400;
  } else if (MediaQuery.of(context).size.width < 900) {
    return MediaQuery.of(context).size.width / 700;
  } else {
    return MediaQuery.of(context).size.width / 1000;
  }
}
