import 'package:flutter/material.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';

/// AyahFlowWidget
/// - يأخذ TafsirPageController ليقرأ selectedAyah و getAyahText وسurahEntity
/// - يعرض الآية السابقة، الحالية، والتالية مع تأثير تدفق رأسي بسيط واحترافي
class AyahsFlowWidget extends StatelessWidget {
  final TafsirPageController tafsirPageController;

  const AyahsFlowWidget({
    super.key,
    required this.tafsirPageController,
  });

  String _safeAyahText(int index1Based) {
    // مثال مؤقت للنصوص (بدّلها بمنطقك الحقيقي getAyahText)
    final List<String> strings = List.generate(
      7,
      (index) => "الحمد لله رب العالمين",
    );

    if (index1Based <= 0) return '';
    final idx = index1Based - 1;
    if (idx < 0 || idx >= strings.length) return '';
    return strings[idx];
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int?>(
      valueListenable: tafsirPageController.selectedAyah,
      builder: (context, selected, _) {
        final int total = tafsirPageController.surahEntity.numberOfAyat;
        final int sel = (selected ?? 1).clamp(1, total);
        final String prev = _safeAyahText(sel - 1);
        final String cur = _safeAyahText(sel);
        final String next = _safeAyahText(sel + 1);

        const Curve curve = Curves.easeOutCubic;
        const Duration duration = Duration(milliseconds: 360);
        const double smallOpacity = 0.5;
        const double smallScale = 0.94;
        const double verticalGap = 8.0;

        Widget buildAdjacent(String text) {
          return Opacity(
            opacity: text.isEmpty ? 0.0 : smallOpacity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyles.regular14_150(context),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        }

        // ثابت اتجاه الدخول (بسيط: دخول من الأسفل)
        final inOffsetTween = const Offset(0, 0.3);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // previous
            AnimatedSwitcher(
              duration: duration,
              switchInCurve: curve,
              switchOutCurve: curve,
              transitionBuilder: (child, anim) {
                final offset = Tween<Offset>(
                        begin: const Offset(0, -0.15), end: Offset.zero)
                    .animate(anim);
                final fade = Tween<double>(begin: 0.0, end: 1.0).animate(anim);
                final scale =
                    Tween<double>(begin: 0.98, end: 1.0).animate(anim);
                return FadeTransition(
                  opacity: fade,
                  child: SlideTransition(
                      position: offset,
                      child: ScaleTransition(scale: scale, child: child)),
                );
              },
              child: SizedBox(
                key: ValueKey('prev_$sel'),
                width: double.infinity,
                child: buildAdjacent(prev),
              ),
            ),

            const SizedBox(height: verticalGap),

            // current with simple flow (enter from bottom)
            AnimatedSwitcher(
              duration: duration,
              switchInCurve: curve,
              switchOutCurve: curve,
              layoutBuilder: (currentChild, previousChildren) {
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    ...previousChildren,
                    if (currentChild != null) currentChild,
                  ],
                );
              },
              transitionBuilder: (child, anim) {
                final inOffset =
                    Tween<Offset>(begin: inOffsetTween, end: Offset.zero)
                        .animate(anim);
                final fade = Tween<double>(begin: 0.0, end: 1.0).animate(anim);
                return FadeTransition(
                  opacity: fade,
                  child: SlideTransition(position: inOffset, child: child),
                );
              },
              child: SizedBox(
                key: ValueKey('cur_$sel'),
                width: double.infinity,
                child: Center(
                  child: Text(
                    cur,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyles.bold20(context),
                  ),
                ),
              ),
            ),

            const SizedBox(height: verticalGap),

            // next
            AnimatedSwitcher(
              duration: duration,
              switchInCurve: curve,
              switchOutCurve: curve,
              transitionBuilder: (child, anim) {
                final offset = Tween<Offset>(
                        begin: const Offset(0, 0.15), end: Offset.zero)
                    .animate(anim);
                final fade = Tween<double>(begin: 0.0, end: 1.0).animate(anim);
                final scale =
                    Tween<double>(begin: smallScale, end: 1.0).animate(anim);
                return FadeTransition(
                  opacity: fade,
                  child: SlideTransition(
                      position: offset,
                      child: ScaleTransition(scale: scale, child: child)),
                );
              },
              child: SizedBox(
                key: ValueKey('next_$sel'),
                width: double.infinity,
                child: buildAdjacent(next),
              ),
            ),
          ],
        );
      },
    );
  }
}
