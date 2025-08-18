import 'package:flutter/material.dart';
import 'package:test_app/core/services/arabic_converter_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class RamadanCalendarWidget extends StatelessWidget {
  const RamadanCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: List.generate(30, (index) {
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: _getTopRadius(index),
                      topRight: _getTopRadius(index),
                      bottomLeft: _getBottomRadius(index),
                      bottomRight: _getBottomRadius(index),
                    ),
                  ),
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    _getRamadanDay(index),
                    style: TextStyles.regular16_120(
                      context,
                      color: AppColors.purple,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
        Column(
          children: [
            const SizedBox(height: 25),
            ...List.generate(
              29,
              (index) => SizedBox(
                height: 50,
                width: double.infinity,
                child: Divider(
                  thickness: 3,
                  indent: 10.0,
                  endIndent: 10.0,
                  color: AppColors.white.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getRamadanDay(int index) {
    final int day = index + 1;
    final String arabicNumber =
        sl<BaseArabicConverterService>().convertToArabicDigits(day.toString());
    return '$arabicNumber رمضان';
  }

  Radius _getBottomRadius(int index) {
    return Radius.circular(index != 29 ? 5.0 : 0.0);
  }

  Radius _getTopRadius(int index) {
    return Radius.circular(index != 0 ? 5.0 : 0.0);
  }
}
