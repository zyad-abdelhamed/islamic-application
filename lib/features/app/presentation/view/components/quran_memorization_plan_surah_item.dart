import 'package:flutter/material.dart';
import 'package:test_app/core/services/arabic_converter_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';

class QuranMemorizationPlanSurahItem extends StatelessWidget {
  final SurahEntity surah;
  final List<int> memorizedAyat;

  const QuranMemorizationPlanSurahItem({
    super.key,
    required this.surah,
    required this.memorizedAyat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                surah.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isFullyMemorized
                      ? AppColors.successColor
                      : AppColors.secondryColorInActiveColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "$totalAyahsInArabic آية",
                  style: TextStyle(
                    color: isFullyMemorized
                        ? Colors.white
                        : AppColors.secondryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Highlight if fully memorized
          if (isFullyMemorized)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.successColor.withAlpha(25),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.successColor),
              ),
              child: const Text(
                "تم حفظ السورة كاملة!",
                style: TextStyle(
                  color: AppColors.successColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          if (!isFullyMemorized) ...[
            MemorizedAyatDashedLine(
              totalAyat: surah.numberOfAyat,
              memorizedAyat: memorizedAyat,
            ),
          ],
        ],
      ),
    );
  }

  bool get isFullyMemorized => memorizedAyat.length == surah.numberOfAyat;

  String get totalAyahsInArabic => sl<BaseArabicConverterService>()
      .convertToArabicDigits(surah.numberOfAyat.toString());
}

class MemorizedAyatDashedLine extends StatelessWidget {
  final int totalAyat;
  final List<int> memorizedAyat;

  const MemorizedAyatDashedLine({
    super.key,
    required this.totalAyat,
    required this.memorizedAyat,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double totalWidth = constraints.maxWidth;
      final double dashSpace = 2.0;
      final double dashWidth =
          (totalWidth - (dashSpace * (totalAyat - 1))) / totalAyat;

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(totalAyat, (index) {
          final int ayahNumber = index + 1;
          final bool isMemorized = memorizedAyat.contains(ayahNumber);

          return Container(
            width: dashWidth,
            height: 4,
            margin:
                EdgeInsets.only(right: index == totalAyat - 1 ? 0 : dashSpace),
            decoration: BoxDecoration(
              color: isMemorized
                  ? AppColors.successColor
                  : AppColors.successColor.withAlpha(25),
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
      );
    });
  }
}
