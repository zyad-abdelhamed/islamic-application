import 'package:flutter/material.dart';
import 'package:test_app/core/services/arabic_converter_service.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/controller/controllers/quran_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_cubit.dart';

class SurahsWidget extends StatelessWidget {
  const SurahsWidget({super.key, required this.quranPageController});
  final QuranPageController quranPageController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
          itemCount: quranPageController.surahsInfoList.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final surahInfo = quranPageController.surahsInfoList[index];
            final int pageNum = (surahInfo['page']) - 1;

            return GestureDetector(
              onTap: () {
                QuranCubit.getQuranController(context).goToPageByNumber(
                    quranPageController,
                    pageNum,
                    quranPageController.updateIndexNotifier(context, pageNum));
                Navigator.pop(context);
              },
              child: Container(
                color: quranPageController.indexsNotifier.value.contains(index)
                    ? AppColors.secondryColor
                    : Colors.transparent,
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'سورة ${surahInfo["name"]}',
                      style: TextStyles.bold20(context).copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      _getSurahInfoText(surahInfo),
                      style: TextStyles.semiBold16(
                          context: context, color: Colors.grey),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  String _getSurahInfoText(surahInfo) =>
      '${sl<BaseArabicConverterService>().convertToArabicDigits(surahInfo["ayahs"])} آية\n${surahInfo["type"]}';
}
