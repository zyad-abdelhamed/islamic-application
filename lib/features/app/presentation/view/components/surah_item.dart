import 'package:flutter/material.dart';
import 'package:test_app/core/services/arabic_converter_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';

class SurahItem extends StatelessWidget {
  const SurahItem({
    required this.surah,
    required this.textColor,
    required this.cardColor,
    required this.borderColor,
    required this.borderRadius,
    super.key,
  });

  final SurahEntity surah;
  final Color textColor;
  final Color cardColor;
  final Color borderColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'سورة ${surah.name}',
                style: TextStyles.bold20(context).copyWith(
                  color: textColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _getSurahInfoText(surah),
                style: TextStyles.semiBold16(
                  context: context,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  String _getSurahInfoText(SurahEntity surahInfo) {
    final numberOfAyahs = sl<BaseArabicConverterService>()
        .convertToArabicDigits(surahInfo.numberOfAyat.toString());

    return '$numberOfAyahs آية - ${surahInfo.type}';
  }
}
