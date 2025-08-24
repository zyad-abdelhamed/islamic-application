import 'dart:typed_data';

class DailyAdhkarEntity {
  const DailyAdhkarEntity({
    required this.text,
    required this.image,
    required this.isShowed,
    required this.createdAt,
  });

  final String? text;
  final Uint8List? image;
  final bool isShowed;
  final DateTime createdAt; // عشان نعرف إمتى اتسجل
}
