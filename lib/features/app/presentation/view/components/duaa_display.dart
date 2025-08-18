import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class DuaaDisplay extends StatefulWidget {
  const DuaaDisplay({
    super.key,
    required this.duaaTitle,
    required this.duaaBody,
  });

  final String duaaTitle;
  final String duaaBody;

  @override
  State<DuaaDisplay> createState() => _DuaaDisplayState();
}

class _DuaaDisplayState extends State<DuaaDisplay> {
  final ValueNotifier<bool> visibilityNotifier = ValueNotifier(false);

  @override
  void dispose() {
    visibilityNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // عنوان الدعاء + زر السهم
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.duaaTitle,
              style: TextStyles.semiBold16(
               context:  context,
               color:  AppColors.secondryColor,
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: visibilityNotifier,
              builder: (context, visible, _) {
                return AnimatedRotation(
                  duration: const Duration(milliseconds: 300),
                  turns: visible ? 0.5 : 0.0, // تدوير السهم لأعلى/أسفل
                  child: IconButton(
                    onPressed: () => visibilityNotifier.value = !visible,
                    icon: const Icon(Icons.expand_more, size: 30, color: Colors.grey),
                  ),
                );
              },
            ),
          ],
        ),
    
        // محتوى الدعاء المتحرك
        ValueListenableBuilder<bool>(
          valueListenable: visibilityNotifier,
          builder: (context, visible, _) {
            return AnimatedSize(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: visible ? 1.0 : 0.0,
                child: visible
                    ? Container(
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.secondryColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.duaaBody,
                          style: TextStyles.semiBold16_120(context).copyWith(
                              color: AppColors.white,
                              fontFamily: 'DataFontFamily'),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            );
          },
        ),
      ],
    );
  }
}
