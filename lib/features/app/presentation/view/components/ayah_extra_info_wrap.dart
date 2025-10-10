import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/domain/entities/ayah_search_result_entity.dart';

class AyahExtraInfoWrap extends StatelessWidget {
  final SearchAyahEntity ayah;

  const AyahExtraInfoWrap({super.key, required this.ayah});

  bool containsSajda(SearchAyahEntity ayah) => ayah.text.endsWith("۩");

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> infoList = <Map<String, String>>[
      {"label": "رقم الآية الكلي", "value": "${ayah.number}"},
      {"label": "رقم الآية في السورة", "value": "${ayah.numberInSurah}"},
      {"label": "الجزء", "value": "${ayah.juz}"},
      {"label": "الصفحة", "value": "${ayah.page}"},
      {"label": "سجدة", "value": containsSajda(ayah) ? "نعم" : "لا"},
      {"label": "السورة", "value": ayah.surah.name},
      {"label": "رقم السورة", "value": "${ayah.surah.number}"},
      {"label": "الاسم بالإنجليزية", "value": ayah.surah.englishName},
      {"label": "ترجمة الاسم", "value": ayah.surah.englishNameTranslation},
      {"label": "عدد الآيات", "value": "${ayah.surah.numberOfAyahs}"},
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: List.generate(
        infoList.length,
        (index) {
          final Map<String, String> item = infoList[index];
          return _infoItem(item["label"]!, item["value"]!);
        },
      ),
    );
  }

  Widget _infoItem(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.secondryColorInActiveColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.secondryColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
