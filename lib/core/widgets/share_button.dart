import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

/// Reusable ShareButton
/// - text: النص المراد مشاركته (مطلوب أو يمكن تركه فارغ عند مشاركة ملفات)
/// - subject: العنوان/subject (اختياري، مفيد للإيميل)
/// - onComplete: (اختياري) يعيد ShareResult من share_plus بعد انتهاء المستخدم
class ShareButton extends StatelessWidget {
  final String text;
  final String? subject;
  final Color color;

  final void Function(ShareResult? result)? onComplete;

  const ShareButton({
    super.key,
    required this.text,
    this.subject,
    this.color = Colors.grey,
    this.onComplete,
  });

  Future<void> _share(BuildContext context) async {
    try {
      ShareResult? result;
      if (text.isNotEmpty) {
        // share text only
        result = await Share.share(
          text,
          subject: subject,
        );
      } else {
        // nothing to share -> show a small feedback
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لا يوجد شيء للمشاركة')),
        );
      }

      if (onComplete != null) onComplete!(result);
    } catch (e) {
      // خطأ بسيط في المشاركة
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء المشاركة: $e')),
      );
      if (onComplete != null) onComplete!(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _share(context),
      icon: Icon(
        Icons.share,
        color: color,
      ),
    );
  }
}
