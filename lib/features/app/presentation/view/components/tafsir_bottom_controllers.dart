import 'package:flutter/material.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/core/widgets/explain_feature_widget.dart';
import 'controle_font_size_buttons.dart';

class TafsirBottomControls extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final ValueNotifier<double> fontSizeNotfier;
  final VoidCallback onSearch;
  final VoidCallback onInfo;
  final GlobalKey infoButtonKey;

  const TafsirBottomControls({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.fontSizeNotfier,
    required this.onSearch,
    required this.onInfo,
    required this.infoButtonKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: SizedBox(
          width: context.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildOption(Icons.search, "بحث", onSearch),
              _buildOption(Icons.info_outline, "معلومات السورة", onInfo,
                  key: infoButtonKey),
              ExplainFeatureButton(
                text: "هنا هتلاقي شرح لكل الأدوات:\n\n"
                    "🔍 البحث: للبحث داخل السورة.\n"
                    "ℹ️ معلومات: يعرض تفاصيل عن السورة (عدد الآيات، مكان النزول... إلخ).\n"
                    "🔤 التحكم في الخط: لتكبير أو تصغير النص حسب راحتك.",
              ),
              ControleFontSizeButtons(
                fontSizeNotfier: fontSizeNotfier,
                initialFontSize: 25,
              ),
            ],
          ),
        ));
  }

  Widget _buildOption(IconData icon, String label, VoidCallback onTap,
      {GlobalKey? key}) {
    return InkWell(
      key: key,
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: textColor),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(color: textColor, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
