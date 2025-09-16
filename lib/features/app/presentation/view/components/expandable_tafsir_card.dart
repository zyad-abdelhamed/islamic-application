import 'package:flutter/material.dart';
import 'package:test_app/core/widgets/share_button.dart';
import 'package:test_app/features/app/presentation/view/components/copy_button.dart';

class ExpandableTafsirCard extends StatefulWidget {
  final String tafsirText;
  final String title;
  final Color dataColor;
  const ExpandableTafsirCard({
    super.key,
    required this.tafsirText,
    required this.title,
    required this.dataColor,
  });

  @override
  State<ExpandableTafsirCard> createState() => _ExpandableTafsirCardState();
}

class _ExpandableTafsirCardState extends State<ExpandableTafsirCard> {
  late final ValueNotifier<bool> isExpanded;

  @override
  void initState() {
    isExpanded = ValueNotifier<bool>(false);
    super.initState();
  }

  @override
  void dispose() {
    isExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Cairo",
                  color: widget.dataColor,
                ),
              ),
              const Spacer(),
              CopyButton(textToCopy: widget.tafsirText),
              ShareButton(text: widget.tafsirText)
            ],
          ),
          const Divider(height: 20, thickness: 0.8),
          ValueListenableBuilder<bool>(
            valueListenable: isExpanded,
            builder: (context, expanded, _) {
              final textToShow = expanded
                  ? widget.tafsirText
                  : (widget.tafsirText.length > 150
                      ? '${widget.tafsirText.substring(0, 150)}...'
                      : widget.tafsirText);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textToShow,
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.6,
                      fontFamily: "Amiri",
                      color: widget.dataColor,
                    ),
                  ),
                  if (widget.tafsirText.length > 150)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () => isExpanded.value = !expanded,
                        child: Text(
                          expanded ? 'إخفاء' : 'رؤية المزيد',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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
