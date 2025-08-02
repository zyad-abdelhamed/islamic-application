import 'package:flutter/material.dart';
import 'package:test_app/core/services/arabic_converter_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class RamadanCalendarWidget extends StatelessWidget {
  const RamadanCalendarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: List.generate(
            30,
            (index) {
              return Column(children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.secondryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: _getTopRadius(index),
                          topRight: _getTopRadius(index),
                          bottomLeft: _getBottomRadius(index),
                          bottomRight: _getBottomRadius(index))),
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(_getRamadanDay(index),
                      style: TextStyles.regular16_120(context,
                          color: AppColors.purple)),
                )
              ]);
            },
          ),
        ),
        Column(children: [
          SizedBox(
            height: 25,
          ),
          ...List.generate(
              29,
              (index) => SizedBox(
                  //fixed hight to Divider
                  height: 50,
                  width: double.infinity,
                  child: Divider(
                      thickness: 3,
                      indent: 10.0,
                      endIndent: 10.0,
                      color: AppColors.white.withValues(alpha: .5)))),
        ])
      ],
    );
  }

  String _getRamadanDay(int index) {
  // الخطوة 1: زيادة 1 على index
  final int day = index + 1;

  // الخطوة 2: تحويله إلى رقم عربي باستخدام الخدمة
  final String arabicNumber = sl<BaseArabicConverterService>().convertToArabicNumber(day);

  // الخطوة 3: إرجاع النص
  return '$arabicNumber رمضان';
}
}

Radius _getBottomRadius(int index) {
  return Radius.circular(index != 29 //ignore last container
      ? 5.0
      : 0.0);
}

Radius _getTopRadius(int index) {
  return Radius.circular(index != 0 //ignore first container
      ? 5.0
      : 0.0);
}
