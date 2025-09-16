import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';

class SurahInfoTooltip {
  static void show(BuildContext context, SurahEntity surah, GlobalKey key) {
    if (key.currentContext == null) return;

    final renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size; // حجم الزر نفسه
    final offset = renderBox.localToGlobal(Offset.zero); // مكان الزر على الشاشة

    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // عشان نقفل الـ Tooltip لما ندوس في أي مكان
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => entry.remove(),
            ),

            Positioned(
              left: offset.dx + size.width / 2 - 100, // يخلي الكارت متمركز
              top: offset.dy - 190, // يطلع فوق الزر بمسافة
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    // الكارت
                    Container(
                      width: 200,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("📖 سورة ${surah.name}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const Divider(),
                          _buildInfoRow(
                              "📝 عدد الآيات:", "${surah.numberOfAyat}"),
                          _buildInfoRow("📍 النوع:", surah.type),
                          _buildInfoRow("📄رقم الصفحة:", "${surah.pageNumber}"),
                          _buildInfoRow("⬇️ الحالة:",
                              surah.isDownloaded ? "محفوظة" : "غير محفوظة"),
                        ],
                      ),
                    ),
                    // المثلث يشاور على الزر
                    CustomPaint(
                      painter: _TrianglePainter(
                        color: AppColors.successColor,
                      ),
                      child: const SizedBox(width: 20, height: 10),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(entry);
  }

  static Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        spacing: 5,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(value),
        ],
      ),
    );
  }
}

/// رسمة المثلث
class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(0, 0) // بداية من الشمال فوق
      ..lineTo(size.width / 2, size.height) // البوز لتحت
      ..lineTo(size.width, 0) // يمين فوق
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
