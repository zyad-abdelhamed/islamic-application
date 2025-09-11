import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/domain/entities/ayah_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_with_tafsir_entity.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_state.dart';
import 'package:test_app/features/app/presentation/view/components/erorr_widget.dart';
import 'package:test_app/features/app/presentation/view/components/tafsir_ayah_widget.dart';

class GetSurahWithTafsirSuccessStateView extends StatelessWidget {
  const GetSurahWithTafsirSuccessStateView({
    super.key,
    required this.state,
    required this.controller,
  });

  final GetSurahWithTafsirSuccess state;
  final TafsirPageController controller;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color textColor = Colors.brown;
    final Color backgroundColor = isDark
        ? AppColors.darkModeInActiveColor
        : AppColors.lightModeInActiveColor;
    final Color ayahNumberColor = Theme.of(context).primaryColor;

    final SurahWithTafsirEntity data = state.surahWithTafsir;
    final List<AyahEntity> items = data.ayahsList;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: items.length + 1, // +1 علشان زر/لودينج/مفيش تاني
      itemBuilder: (context, index) {
        if (index < items.length) {
          final AyahEntity ayah = items[index];
          return TafsirAyahWidget(
            controller: controller,
            ayah: ayah,
            ayahNumberColor: ayahNumberColor,
            textColor: textColor,
            backgroundColor: backgroundColor,
            isDark: isDark,
          );
        } else {
          //  آخر عنصر: حسب الحالة نعرض زر عرض المزيد أو لودينج أو رسالة
          if (state.isLoadingMore) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: GetAdaptiveLoadingWidget(),
            );
          } else if (state.hasMore) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.tafsirCubit.loadMore();
                  },
                  child: const Text("عرض المزيد"),
                ),
              ),
            );
          } else if (state.loadMoreError != null) {
            return ErrorWidgetIslamic(
              message: state.loadMoreError!,
              buttonWidget: Text(AppStrings.translate("tryAgain")),
              onPressed: () => controller.tafsirCubit.retry(),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text("تم عرض كل الآيات "),
              ),
            );
          }
        }
      },
    );
  }
}
