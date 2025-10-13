import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';
import 'package:test_app/features/app/presentation/view/pages/reciters_page.dart';
import 'controle_font_size_buttons.dart';

class TafsirBottomControls extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final TafsirPageController controller;
  final VoidCallback onSearch;
  final VoidCallback onInfo;
  final GlobalKey infoButtonKey;

  const TafsirBottomControls({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.controller,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildOption(
              Icons.search,
              onSearch,
            ),
            _buildOption(
              Icons.info_outline,
              onInfo,
              key: infoButtonKey,
            ),
            _buildOption(CupertinoIcons.headphones, () {}),
            _buildOption(CupertinoIcons.group, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecitersPage(
                            controller: controller,
                          )));
            }),
            ControleFontSizeButtons(
              fontSizeNotfier: controller.fontSizeNotifier,
              initialFontSize: 25,
            ),
          ],
        ));
  }

  Widget _buildOption(IconData icon, VoidCallback onTap, {GlobalKey? key}) {
    return InkWell(
      key: key,
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Icon(icon, color: textColor),
      ),
    );
  }
}
