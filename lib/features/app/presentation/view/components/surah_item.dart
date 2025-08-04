import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Icon(CupertinoIcons.chevron_right,
              color: Theme.of(context).primaryColor, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'سورة ${surah['name']}',
                  style: TextStyles.semiBold18(context, textColor)
                      .copyWith(fontFamily: 'DataFontFamily'),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'عدد الآيات: ${surah['ayahs']}',
                      style:
                          TextStyles.regular16_120(context, color: Colors.grey),
                    ),
                    Text(
                      surah['type'],
                      style:
                          TextStyles.regular16_120(context, color: Colors.grey),
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
