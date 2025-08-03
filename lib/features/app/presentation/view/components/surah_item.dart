import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class SurahItem extends StatelessWidget {
  const SurahItem({
    required this.surah,
    required this.textColor,
    required this.cardColor,
    super.key,
  });

  final Map<String, dynamic> surah;
  final Color textColor;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            offset: const Offset(0, 4),
            blurRadius: 6,
          ),
        ],
        border: Border.all(
          color: AppColors.secondryColor.withValues(alpha: 0.8),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.menu_book_outlined,
              color: AppColors.secondryColor, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'سورة ${surah['name']}',
                  style: TextStyles.semiBold18(context, textColor).copyWith(
                    fontFamily: 'DataFontFamily',
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'عدد الآيات: ${surah['ayahs']}',
                      style:
                          TextStyles.regular16_120(context, color: textColor),
                    ),
                    Text(
                      surah['type'],
                      style:
                          TextStyles.regular16_120(context, color: textColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
