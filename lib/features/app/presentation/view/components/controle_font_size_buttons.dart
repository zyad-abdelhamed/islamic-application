import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/text_styles.dart';

class ControleFontSizeButtons extends StatelessWidget {
  const ControleFontSizeButtons(
      {super.key,
      required this.fontSizeNotfier,
      required this.initialFontSize});

  final ValueNotifier<double> fontSizeNotfier;
  final double initialFontSize;
  void increaseFontSize() {
    final double maxValue = initialFontSize + 10;
    if (fontSizeNotfier.value <= maxValue) {
      fontSizeNotfier.value++;
    }
    return;
  }

  void decreaseFontSize() {
    final double minValue = initialFontSize - 10;
    if (fontSizeNotfier.value >= minValue) {
      fontSizeNotfier.value--;
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> controleTextFontSizeButtonsData = [
      {"onTap": increaseFontSize, "fontSize": 23.0.toDouble()},
      {"onTap": decreaseFontSize, "fontSize": 18.0.toDouble()}
    ];

    return Row(
      spacing: 10.0,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          2,
          (index) => _controleTextFontSizeButton(context,
              fontSize: controleTextFontSizeButtonsData[index]["fontSize"],
              onTap: controleTextFontSizeButtonsData[index]["onTap"])),
    );
  }

  GestureDetector _controleTextFontSizeButton(BuildContext context,
      {required double fontSize, required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Text(AppStrings.translate("fontSizeButtonText"),
          style: TextStyles.bold20(context).copyWith(
              color: Colors.grey, fontSize: fontSize, fontFamily: "normal")),
    );
  }
}
