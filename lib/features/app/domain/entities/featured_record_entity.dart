class FeaturedRecordEntity {
  final int id;
  final int value;

  FeaturedRecordEntity({
    int? id,
    required this.value,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch;
}
