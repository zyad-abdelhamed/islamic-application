import 'package:flutter/material.dart';
import 'package:test_app/core/constants/constants_values.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/presentation/view/pages/speech_page.dart';

class AyahRangePickerDialog extends StatefulWidget {
  final SurahEntity surah;
  final List<int> memorizedAyahs;
  final int index;

  const AyahRangePickerDialog({
    super.key,
    required this.surah,
    required this.memorizedAyahs,
    required this.index,
  });

  @override
  State<AyahRangePickerDialog> createState() => _AyahRangePickerDialogState();
}

class _AyahRangePickerDialogState extends State<AyahRangePickerDialog> {
  late int selectedOffset;
  late int selectedLimit;

  @override
  void initState() {
    super.initState();
    selectedOffset = 1;
    selectedLimit = widget.surah.numberOfAyat;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "اختر نطاق الآيات التي تريد مراجعتها",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("اختر أول آية (بداية المراجعة):"),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: DropdownButton<int>(
              key: ValueKey(selectedOffset),
              value: selectedOffset,
              isExpanded: true,
              items: List.generate(selectedLimit, (i) => i + 1)
                  .map((number) => DropdownMenuItem(
                        value: number,
                        child: Text(
                          "آية $number",
                          style: TextStyle(
                            color: widget.memorizedAyahs.contains(number)
                                ? Colors.green
                                : null,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedOffset = value;
                    if (selectedLimit < selectedOffset + 6) {
                      selectedLimit = (selectedOffset + 6 <= selectedLimit)
                          ? selectedOffset + 6
                          : selectedLimit;
                    }
                  });
                }
              },
            ),
          ),
          const SizedBox(height: 12),
          const Text("اختر آخر آية (نهاية المراجعة):"),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: DropdownButton<int>(
              key: ValueKey(selectedLimit),
              value: selectedLimit,
              isExpanded: true,
              items: List.generate(selectedLimit, (i) => i + 1)
                  .where((n) => n >= selectedOffset + 6)
                  .map((n) => DropdownMenuItem(
                        value: n,
                        child: Text(
                          "آية $n",
                          style: TextStyle(
                            color: widget.memorizedAyahs.contains(n)
                                ? AppColors.successColor
                                : null,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedLimit = value;
                  });
                }
              },
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.start,
      actions: [
        MaterialButton(
          color: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(ConstantsValues.fullCircularRadius),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return SpeechPage(
                surahRequestParams: SurahRequestParams(
                  surah: widget.surah,
                  surahNumber: widget.index + 1,
                  offset: selectedOffset,
                  limit: selectedLimit - selectedOffset + 1,
                ),
              );
            }));
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "تأكيد",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("إلغاء"),
        ),
      ],
    );
  }
}
