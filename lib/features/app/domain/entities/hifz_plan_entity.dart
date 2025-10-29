import 'package:test_app/features/app/domain/entities/surah_prograss_entity.dart';

class HifzPlanEntity {
  final String planName; // اسم الخطة
  final DateTime createdAt; // تاريخ إنشاء الخطة
  final String lastProgress; // آخر تقدم نصي (مثلاً: من الآية كذا إلى كذا)
  final List<SurahProgressEntity> surahsProgress; // قائمة بالسور اللى فيها تقدم

  const HifzPlanEntity({
    required this.planName,
    required this.createdAt,
    required this.lastProgress,
    required this.surahsProgress,
  });
}
