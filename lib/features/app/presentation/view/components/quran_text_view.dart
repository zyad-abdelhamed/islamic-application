import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_app/features/app/presentation/view/components/ayah_number_widget.dart';

class QuranTextView extends StatelessWidget {
  final List<Map<String, dynamic>> ayat;
  final ValueNotifier<int?> selectedAyah;
  final void Function(int ayahNum) onLongPress;

  const QuranTextView({
    super.key,
    required this.ayat,
    required this.selectedAyah,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ValueListenableBuilder<int?>(
          valueListenable: selectedAyah,
          builder: (context, value, child) {
            return SelectableText.rich(
              TextSpan(
                children: AyahTextSpanBuilder.build(
                  ayat,
                  selectedAyah,
                  onLongPress,
                ),
              ),
              textAlign: TextAlign.right,
            );
          },
        ),
      ),
    );
  }
}

class AyahTextSpanBuilder {
  static List<InlineSpan> build(
    List<Map<String, dynamic>> ayat,
    ValueNotifier<int?> selectedAyah,
    void Function(int ayahNum) onLongPress,
  ) {
    final List<InlineSpan> spans = [];
    const TextStyle baseStyle = TextStyle(
      fontSize: 20,
      height: 1.8,
      fontFamily: 'Amiri',
      color: Colors.black,
    );

    for (var i = 0; i < ayat.length; i++) {
      final text = ayat[i]['text'] as String;
      final num = ayat[i]['num'] as int;
      final sajda = ayat[i]['sajda'] as bool;

      final isSelected = selectedAyah.value == num;

      spans.add(
        TextSpan(
          text: "$text ",
          style: isSelected
              ? baseStyle.copyWith(
                  backgroundColor: Colors.green.withOpacity(0.3),
                )
              : baseStyle,
          recognizer: (LongPressGestureRecognizer()
            ..onLongPress = () {
              onLongPress(num);
            }),
        ),
      );

      // ✅ رقم الآية
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: AyahNumberWidget(number: num),
          ),
        ),
      );

      // ✅ علامة السجدة
      if (sajda) {
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Image.asset(
                'assets/images/sajdah.png',
                height: 30,
              ),
            ),
          ),
        );
      }

      // ✅ مسافة بين الآيات
      if (i != ayat.length - 1) {
        spans.add(const TextSpan(text: '   '));
      }
    }

    return spans;
  }
}
