import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/domain/entities/ayah_entity.dart';

class QuranTextView extends StatelessWidget {
  final List<AyahEntity> ayat;
  final ValueNotifier<int?> selectedAyah;
  final ValueNotifier<double> fontSizeNotifier;
  final void Function(int ayahNum) onLongPress;

  const QuranTextView({
    super.key,
    required this.ayat,
    required this.selectedAyah,
    required this.fontSizeNotifier,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: ListenableBuilder(
        listenable: Listenable.merge([fontSizeNotifier, selectedAyah]),
        builder: (context, _) {
          return RichText(
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.justify,
            textWidthBasis: TextWidthBasis.parent,
            text: TextSpan(
              children: _getSpans(context),
            ),
          );
        },
      ),
    );
  }

  List<InlineSpan> _getSpans(BuildContext context) {
    final Color dataColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey
        : Colors.black;

    final List<InlineSpan> spans = [];

    TextStyle baseStyle = TextStyle(
      fontSize: fontSizeNotifier.value,
      height: 1.9,
      fontFamily: 'Amiri',
      color: dataColor,
    );

    for (int i = 0; i < ayat.length; i++) {
      final String text = ayat[i].text;
      final int num = ayat[i].number;
      final bool sajda = ayat[i].sajda;
      final bool isSelected = (selectedAyah.value == num);

      // نص الآية
      spans.add(
        TextSpan(
          text: "$text ",
          style: isSelected
              ? baseStyle.copyWith(
                  backgroundColor: AppColors.successColor.withOpacity(0.3),
                )
              : baseStyle,
          recognizer: (LongPressGestureRecognizer()
            ..onLongPress = () {
              onLongPress(num);
            }),
        ),
      );

      // رقم الآية (نفس الشكل القديم)
      spans.add(
        TextSpan(
          text: "﴿$num﴾ ",
          style: baseStyle.copyWith(
            fontSize: baseStyle.fontSize! * 0.85,
            color: Theme.of(context).primaryColor,
          ),
        ),
      );

      // علامة السجدة
      if (sajda) {
        spans.add(
          TextSpan(
            text: "🧎‍♂️ ",
            style: baseStyle.copyWith(
              fontSize: baseStyle.fontSize! * 1.2,
              color: Theme.of(context).primaryColor,
            ),
          ),
        );
      }

      // مسافة صغيرة بين الآيات
      spans.add(const TextSpan(text: " "));
    }

    return spans;
  }
}
