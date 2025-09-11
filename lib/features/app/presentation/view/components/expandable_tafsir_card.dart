import 'package:flutter/material.dart';
import 'package:test_app/features/app/presentation/view/components/copy_button.dart';

class ExpandableTafsirCard extends StatelessWidget {
  final String tafsirText;
  final Color color;
  final String title;

  const ExpandableTafsirCard({
    super.key,
    required this.tafsirText,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isExpanded = ValueNotifier(false);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              CopyButton(
                textToCopy: tafsirText,
                color: color,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ValueListenableBuilder<bool>(
            valueListenable: isExpanded,
            builder: (context, expanded, _) {
              final textToShow = expanded
                  ? tafsirText
                  : (tafsirText.length > 150
                      ? '${tafsirText.substring(0, 150)}...'
                      : tafsirText);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textToShow,
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  ),
                  if (tafsirText.length > 150)
                    TextButton(
                      onPressed: () => isExpanded.value = !expanded,
                      child: Text(expanded ? 'إخفاء' : 'رؤية المزيد'),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
