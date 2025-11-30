import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/extentions/media_query_extention.dart';
import 'package:test_app/features/app/data/models/quran_audio_parameters.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';
import 'package:test_app/features/app/presentation/view/components/surah_audio_dwonload_states.dart';

class ReciterCardWidget extends StatelessWidget {
  final ReciterEntity reciter;
  final TafsirPageController controller;

  const ReciterCardWidget({
    super.key,
    required this.reciter,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final cardPadding = context.width * 0.04;
    final imageRadius = context.width * 0.11;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: cardPadding * 0.6,
        horizontal: cardPadding,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Card(
              elevation: 6,
              color: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  left: cardPadding,
                  right: imageRadius * 2.2,
                  top: cardPadding * 0.8,
                  bottom: cardPadding * 0.8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // اسم القارئ
                          Text(reciter.name,
                              style: TextStyles.semiBold20(
                                context,
                              )),
                          SizedBox(height: context.height * 0.007),

                          // اللغة
                          Text(reciter.language,
                              style: TextStyles.semiBold16(
                                  context: context,
                                  color: AppColors.darkModeTextColor)),
                          SizedBox(height: context.height * 0.015),
                        ],
                      ),
                    ),
                    SurahAudioDownloadStates(
                      downloadInfo: reciter.surahAudioDownloadInfo,
                      params: SurahAudioRequestParams(
                        reciterId: reciter.identifier,
                        reciterName: reciter.name,
                        surahNumber: controller.tafsirRequestParams.surahNumber,
                        surahName: controller.surahParams.surah.name,
                      ),
                      controller: controller,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: -imageRadius * 0.3,
            top: -imageRadius * 0.5,
            bottom: -imageRadius * 0.5,
            child: CircleAvatar(
              radius: imageRadius,
              backgroundColor: Colors.grey.shade800,
              backgroundImage: AssetImage(reciter.image),
            ),
          ),
        ],
      ),
    );
  }
}
