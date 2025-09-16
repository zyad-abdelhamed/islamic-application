import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';
import 'package:test_app/features/app/presentation/view/components/surah_info_tool_tip.dart';
import 'package:test_app/features/app/presentation/view/components/tafsir_bottom_controllers.dart';
import 'package:test_app/features/app/presentation/view/pages/q_and_a_page.dart';
import 'package:test_app/features/app/presentation/view/pages/tafsier_page.dart';

class TafsirPageOverLayout extends StatelessWidget {
  const TafsirPageOverLayout({
    super.key,
    required this.widget,
    required TafsirPageController controller,
  }) : _controller = controller;

  final TafsirPage widget;
  final TafsirPageController _controller;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor = isDark ? Colors.black : Colors.white;
    final Color textColor = isDark ? Colors.white : Colors.black;

    return Stack(
      children: [
        // AppBar
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          top: _controller.isShowed.value ? 0 : -80,
          left: 0,
          right: 0,
          child: AppBar(
            backgroundColor: backgroundColor,
            toolbarHeight: 80,
            leading: const GetAdaptiveBackButtonWidget(
                backBehavior: BackBehavior.pop),
            title: Text(
              'سورة ${widget.tafsirRequestParams.surah.name}',
            ),
          ),
        ),

        // BottomControls
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: _controller.isShowed.value ? 0 : -100,
          left: 0,
          right: 0,
          child: TafsirBottomControls(
            backgroundColor: backgroundColor,
            textColor: textColor,
            fontSizeNotfier: _controller.fontSizeNotifier,
            onSearch: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return QAndAPage(cubit: _controller.tafsirCubit);
              }));
            },
            onInfo: () {
              SurahInfoTooltip.show(
                context,
                widget.surahEntity,
                _controller.infoKey,
              );
            },
            infoButtonKey: _controller.infoKey,
          ),
        ),
      ],
    );
  }
}
