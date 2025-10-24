import 'package:flutter/material.dart';

class AyahRichText extends StatelessWidget {
  final bool hideText;
  final int? selectedAyah;
  final Map<int, int> progress;
  final List<Map<String, dynamic>> ayat;

  const AyahRichText({
    super.key,
    required this.hideText,
    required this.selectedAyah,
    required this.progress,
    required this.ayat,
  });

  @override
  Widget build(BuildContext context) {
    const baseStyle = TextStyle(
      fontSize: 24,
      height: 1.9,
      fontFamily: 'Amiri',
      color: Colors.black,
    );

    final spans = <InlineSpan>[];
    for (var ayah in ayat) {
      final num = ayah['num'] as int;
      final text = ayah['text'] as String;
      final isSelected = selectedAyah == num;
      final words = text.split(" ");
      final currentProgress = progress[num] ?? 0;

      for (int i = 0; i < words.length; i++) {
        final showWord = !hideText || i < currentProgress;
        final isCurrent = isSelected && i == currentProgress;

        spans.add(
          TextSpan(
            text: showWord ? "${words[i]} " : "•••• ",
            style: baseStyle.copyWith(
              backgroundColor:
                  isCurrent ? Colors.teal.withOpacity(0.3) : Colors.transparent,
              color: showWord
                  ? (isCurrent ? Colors.teal.shade900 : Colors.black)
                  : Colors.grey.shade400,
            ),
          ),
        );
      }

      spans.add(
        TextSpan(
          text: "﴿$num﴾ ",
          style: baseStyle.copyWith(
            fontSize: 20,
            color: Colors.teal,
          ),
        ),
      );
    }

    return RichText(
      textAlign: TextAlign.justify,
      textDirection: TextDirection.rtl,
      text: TextSpan(children: spans),
    );
  }
}
