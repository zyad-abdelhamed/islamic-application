import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/widgets/app_divider.dart';
import 'package:test_app/core/widgets/share_button.dart';
import 'package:test_app/features/app/data/models/quran_audio_parameters.dart';
import 'package:test_app/features/app/domain/entities/ayah_search_result_entity.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';
import 'package:test_app/features/app/presentation/controller/controllers/ayah_audio_card_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/tafsir_state.dart';
import 'package:test_app/features/app/presentation/view/components/ayah_audio_card.dart';
import 'package:test_app/features/app/presentation/view/components/ayah_extra_info_wrap.dart';
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

  static AyahAudioCardController? _activeController;

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
              final SearchAyahEntity ayah = ayahs[index] as SearchAyahEntity;
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
                          IconButton(
                            onPressed: () => onPressed(context, ayah),
                            icon: const Icon(Icons.headphones),
                          ),
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
                        AyahExtraInfoWrap(ayah: ayah),
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

  void onPressed(BuildContext context, SearchAyahEntity ayah) {
    // ✅ 1. فك الكنترولر السابق لو موجود
    _activeController?.dispose();
    _activeController = null;

    // ✅ 2. بناء رابط الصوت
    final String audioUrl = sl<BaseQuranRepo>().getAyahAudioUrl(
      AyahAudioRequestParams(
        edition: "ar.alafasy",
        ayahGlobalNumber: ayah.number,
      ),
    );

    final AudioSource source = AudioSource.uri(Uri.parse(audioUrl));

    // ✅ 3. إنشاء الكنترولر الجديد
    final controller = AyahAudioCardController(audioSource: source);
    _activeController = controller;

    // ✅ 4. بناء الكارد وربطه بالكنترولر
    final entry = OverlayEntry(
      builder: (_) => AyahAudioCard(
        key: ValueKey<int>(ayah.number),
        controller: controller,
        reciterName: "مشاري راشد العفاسي",
        reciterImageUrl: "assets/images/book.png",
      ),
    );

    controller.setEntry(entry);
    Overlay.of(context).insert(entry);
  }
}
