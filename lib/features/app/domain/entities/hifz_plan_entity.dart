import 'package:test_app/features/app/domain/entities/surah_prograss_entity.dart';

class HifzPlanEntity {
  final String planName;
  final DateTime createdAt;
  final String lastProgress;
  final Map<String, SurahProgressEntity> surahsProgress;

  const HifzPlanEntity({
    required this.planName,
    required this.createdAt,
    required this.lastProgress,
    required this.surahsProgress,
  });
}
