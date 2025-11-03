import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';
import 'package:test_app/features/app/domain/entities/ayah_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/speech_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/erorr_widget.dart';
import 'package:test_app/features/app/presentation/view/components/handle_speech_update.dart';
import 'package:test_app/features/app/presentation/view/components/value_listenable_builder4.dart';
import 'package:test_app/features/app/presentation/view/components/ayah_rich_text.dart';
import 'package:test_app/features/app/presentation/view/components/speech_bottom_bar.dart';

class SpeechPage extends StatefulWidget {
  const SpeechPage({super.key, required this.surahRequestParams});

  final SurahRequestParams surahRequestParams;

  @override
  State<SpeechPage> createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  late final ValueNotifier<bool> hideTextNotifier;
  late final ValueNotifier<String> displayedTextNotifier;
  late final ValueNotifier<int?> selectedAyahNotifier;
  late final ValueNotifier<Map<int, int>> ayahProgressNotifier;
  late final ValueNotifier<String?> effectNotifier;

  String lastSpokenWord = "";

  late final List<AyahEntity> ayat;

  @override
  void initState() {
    super.initState();

    hideTextNotifier = ValueNotifier<bool>(false);
    displayedTextNotifier = ValueNotifier<String>("");
    selectedAyahNotifier = ValueNotifier<int?>(null);
    ayahProgressNotifier = ValueNotifier<Map<int, int>>({});
    effectNotifier = ValueNotifier<String?>(null);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<SpeechCubit>();
      cubit.initialize(widget.surahRequestParams);
    });
  }

  @override
  void dispose() {
    hideTextNotifier.dispose();
    displayedTextNotifier.dispose();
    selectedAyahNotifier.dispose();
    ayahProgressNotifier.dispose();
    effectNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SpeechCubit>();

    return Scaffold(
      body: BlocConsumer<SpeechCubit, SpeechState>(
        listener: (context, state) {
          if (state is GetAyahsSuccess) {
            ayat = state.ayahs;
          }
          if (state is SpeechUpdated) {
            SpeechHandler.handleSpeechUpdate(
              state: state,
              cubit: cubit,
              ayat: ayat,
              displayedTextNotifier: displayedTextNotifier,
              ayahProgressNotifier: ayahProgressNotifier,
              selectedAyahNotifier: selectedAyahNotifier,
              effectNotifier: effectNotifier,
              mounted: mounted,
              setState: setState,
              lastSpokenWord: lastSpokenWord,
            );
          }
        },
        builder: (context, state) {
          if (state is SpeechInitial || state is GetAyahsLoading) {
            return const AppLoadingWidget();
          } else if (state is GetAyahsFailure) {
            return ErrorWidgetIslamic(message: state.failure);
          } else if (state is GetAyahsSuccess) {
            final ayat = state.ayahs;
            selectedAyahNotifier.value = ayat.first.number;
            final initMap = {for (var a in ayat) a.number: 0};
            ayahProgressNotifier.value = initMap;

            return ValueListenableBuilder<String?>(
              valueListenable: effectNotifier,
              builder: (_, effect, __) {
                final bgColor = switch (effect) {
                  'correct' => Colors.green.shade100,
                  'error' => Colors.red.shade100,
                  _ => const Color(0xFFE9F6EB),
                };

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: bgColor,
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 20),
                          child: ValueListenableBuilder4<bool, int?,
                              Map<int, int>, String?>(
                            hideTextNotifier,
                            selectedAyahNotifier,
                            ayahProgressNotifier,
                            effectNotifier,
                            builder: (_, hide, selected, progress, __) {
                              return AyahRichText(
                                hideText: hide,
                                selectedAyah: selected,
                                progress: progress,
                                ayat: ayat,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ValueListenableBuilder<String>(
                        valueListenable: displayedTextNotifier,
                        builder: (_, text, __) => AnimatedOpacity(
                          opacity: text.isEmpty ? 0 : 1,
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            text,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: SpeechBottomBar(hideTextNotifier: hideTextNotifier),
    );
  }
}
