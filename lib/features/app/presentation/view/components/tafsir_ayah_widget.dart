import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';

class TafsirAyahWidget extends StatelessWidget {
  final TafsirAyahEntity ayah;
  final Color ayahNumberColor;
  final Color textColor;
  final bool isDark;

  const TafsirAyahWidget({
    super.key,
    required this.ayah,
    required this.ayahNumberColor,
    required this.textColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
       margin: EdgeInsets.only(
              top: 30.0
            ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.grey1,
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
                  '${ayah.number}',
                  style: TextStyles.semiBold16_120(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            ayah.text,
            textAlign: TextAlign.justify,
            style: TextStyles.bold20(context)
                .copyWith(fontFamily: 'DataFontFamily', color: textColor),
          ),
        ],
      ),
    );
  }
}
