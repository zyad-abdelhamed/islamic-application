import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/widgets/app_divider.dart';
import 'package:test_app/core/widgets/share_button.dart';
import 'package:test_app/features/app/domain/entities/ayah_search_result_entity.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/ayah_audio_card_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/tafsir_state.dart';
import 'package:test_app/features/app/presentation/view/components/ayah_audio_card.dart';
import 'package:test_app/features/app/presentation/view/components/copy_button.dart';
import 'package:test_app/features/app/presentation/view/components/go_to_Tafsir_edit_page_button.dart';

class AyahsSearchResultPageView extends StatelessWidget {
  const AyahsSearchResultPageView({
    super.key,
    required PageController pageController,
    required this.ayahs,
    required this.tafsirAyahs,
    required this.showExtraInfo,
  }) : _pageController = pageController;

  final PageController _pageController;
  final List ayahs;
  final Map<String, List<TafsirAyahEntity>> tafsirAyahs;
  final bool showExtraInfo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TafsirEditCubit>(
      create: (_) => sl<TafsirEditCubit>(),
      child: BlocBuilder<TafsirEditCubit, TafsirEditState>(
        builder: (context, tafsirState) {
          final List<String> selectedTafsirs = tafsirState.selected;

          return PageView.builder(
            controller: _pageController,
            itemCount: ayahs.length,
            itemBuilder: (context, index) {
              final ayah = ayahs[index];
              final Map<String, TafsirAyahEntity> allTafsir = Map.fromEntries(
                selectedTafsirs.map((editionName) {
                  return MapEntry(
                    editionName,
                    tafsirAyahs[editionName]![index],
                  );
                }),
              );

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      // العنوان العلوي
                      Row(
                        children: [
                          const GoToTafsirEditPageButton(),
                          ShareButton(text: ayah.text),
                          IconButton(onPressed: () {
              final controller = AyahAudioCardController(
                audioSource: AudioSource.uri(Uri.parse(
                    "https://cdn.islamic.network/quran/audio/128/ar.alafasy/262.mp3")),
              );

              final entry = OverlayEntry(
                builder: (_) => AyahAudioCard(
                  controller: controller,
                  reciterName: "مشاري راشد العفاسي",
                  reciterImageUrl: "",
                ),
              );

              controller.setEntry(entry);
              Overlay.of(context).insert(entry);
            }, icon: const Icon(Icons.headphones)),
                          const Spacer(),
                          Text(
                            "${index + 1} / ${ayahs.length}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // نص الآية
                      Center(
                        child: Text(
                          "﴿ ${ayah.text} ﴾",
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Amiri',
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // 👇 لو showExtraInfo == true اعرض بيانات إضافية
                      if (showExtraInfo == true) ...[
                        _buildExtraInfo(ayah),
                        const SizedBox(height: 12),
                      ],

                      const AppDivider(),
                      const SizedBox(height: 8),
                      ...List.generate(selectedTafsirs.length, (i) {
                        final source = selectedTafsirs[i];
                        final TafsirAyahEntity tafsir =
                            allTafsir[source] as TafsirAyahEntity;

                        return ExpansionTile(
                          key: PageStorageKey<String>(source),
                          title: Text(
                            source,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ShareButton(text: tafsir.text),
                                      CopyButton(
                                        textToCopy: tafsir.text,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    tafsir.text,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      })
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildExtraInfo(SearchAyahEntity ayah) {
    final List<Map<String, String>> infoList = <Map<String, String>>[
      {"label": "رقم الآية الكلي", "value": "${ayah.number}"},
      {"label": "رقم الآية في السورة", "value": "${ayah.numberInSurah}"},
      {"label": "الجزء", "value": "${ayah.juz}"},
      {"label": "الصفحة", "value": "${ayah.page}"},
      {"label": "سجدة", "value": containsSajda(ayah) ? "نعم" : "لا"},
      {"label": "السورة", "value": ayah.surah.name},
      {"label": "رقم السورة", "value": "${ayah.surah.number}"},
      {"label": "الاسم بالإنجليزية", "value": ayah.surah.englishName},
      {"label": "ترجمة الاسم", "value": ayah.surah.englishNameTranslation},
      {"label": "عدد الآيات", "value": "${ayah.surah.numberOfAyahs}"},
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: List.generate(
        infoList.length,
        (index) {
          final Map<String, String> item = infoList[index];
          return _infoItem(item["label"]!, item["value"]!);
        },
      ),
    );
  }

  bool containsSajda(SearchAyahEntity ayah) => ayah.text.endsWith("۩");

  Widget _infoItem(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.secondryColorInActiveColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.secondryColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
