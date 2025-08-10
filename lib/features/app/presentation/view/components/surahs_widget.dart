import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/helper_function/get_from_json.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_cubit.dart';

class SurahsWidget extends StatelessWidget {
  const SurahsWidget({super.key});

  Future<List<Map<String, dynamic>>> loadSurahs() async {
    final Map<String, dynamic> data = await getJson(RoutesConstants.surahsJsonRouteName);
    return List<Map<String, dynamic>>.from(data["surahs"]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: loadSurahs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GetAdaptiveLoadingWidget();
          } else if (snapshot.hasError) {
            return const Center(child: Text('حدث خطأ أثناء تحميل السور'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا توجد سور متاحة'));
          }

          final List<Map<String, dynamic>> surahs = snapshot.data!;

          return ListView.builder(
            itemCount: surahs.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final surah = surahs[index];
              final String surahName = surah['name'] ?? 'بدون اسم';
              final int pageNum = (surah['page'] ?? 1) - 1;

              return Container(
                color: index == QuranCubit.getQuranController(context).state.cIndex
                    ? AppColors.secondryColor
                    : Colors.transparent,
                child: TextButton(
                  onPressed: () {
                    QuranCubit.getQuranController(context)
                        .goToPageByNumber(pageNum, index);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'سورة $surahName',
                    style: TextStyles.bold20(context).copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
