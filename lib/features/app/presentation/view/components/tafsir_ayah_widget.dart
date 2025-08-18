import 'package:flutter/material.dart';
import 'package:test_app/core/services/arabic_converter_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';

class TafsirAyahWidget extends StatelessWidget {
  final TafsirAyahEntity ayah;
  final Color ayahNumberColor;
  final Color textColor;
  final bool isDark;
  final Color backgroundColor;
  final TafsirPageController controller;

  const TafsirAyahWidget(
      {super.key,
      required this.ayah,
      required this.ayahNumberColor,
      required this.textColor,
      required this.isDark,
      required this.backgroundColor,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/rub-el-hizb.png',
                  width: 40,
                  height: 40,
                  color: ayahNumberColor,
                ),
                Text(
                  sl<BaseArabicConverterService>().convertToArabicDigits(ayah.number.toString()),
                  style: TextStyles.semiBold16_120(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<double>(
            valueListenable: controller.fontSizeNotfier,
            builder: (_, value, __) => Text(
              ayah.text,
              textAlign: TextAlign.justify,
              style: TextStyles.bold20(context).copyWith(
                fontSize: value,
                fontFamily: 'DataFontFamily',
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
