import 'package:flutter/material.dart';
import 'package:test_app/core/services/arabic_converter_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';

class AyahNumberWidget extends StatelessWidget {
  final int number;
  final Color numberColor;

  const AyahNumberWidget({
    super.key,
    required this.number,
    required this.numberColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset("assets/images/rub-el-hizb.png",
            fit: BoxFit.contain,
            color: Theme.of(context).primaryColor,
            width: 33,
            height: 33),
        Text(
          getAyahNumber,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: numberColor,
          ),
        ),
      ],
    );
  }

  String get getAyahNumber =>
      sl<BaseArabicConverterService>().convertToArabicDigits(number.toString());
}
