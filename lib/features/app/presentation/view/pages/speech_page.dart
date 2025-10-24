import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/presentation/controller/cubit/speech_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/handle_speech_update.dart';
import 'package:test_app/features/app/presentation/view/components/value_listenable_builder4.dart';
import 'package:test_app/features/app/presentation/view/components/ayah_rich_text.dart';
import 'package:test_app/features/app/presentation/view/components/speech_bottom_bar.dart';

class SpeechPage extends StatefulWidget {
  const SpeechPage({super.key});

  @override
  State<SpeechPage> createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  final hideTextNotifier = ValueNotifier<bool>(false);
  final displayedTextNotifier = ValueNotifier<String>("");
  final selectedAyahNotifier = ValueNotifier<int?>(null);
  final ayahProgressNotifier = ValueNotifier<Map<int, int>>({});
  final effectNotifier = ValueNotifier<String?>(null);
  String lastSpokenWord = "";

  final List<Map<String, dynamic>> ayat = [
    {"num": 1, "text": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ"},
    {"num": 2, "text": "الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ"},
    {"num": 3, "text": "الرَّحْمَٰنِ الرَّحِيمِ"},
    {"num": 4, "text": "مَالِكِ يَوْمِ الدِّينِ"},
    {"num": 5, "text": "إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ"},
    {"num": 6, "text": "اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ"},
    {
      "num": 7,
      "text":
          "صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ"
    },
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<SpeechCubit>();
      cubit.initialize();

      selectedAyahNotifier.value = ayat.first['num'];
      final initMap = {for (var a in ayat) a['num'] as int: 0};
      ayahProgressNotifier.value = initMap;
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
        },
      ),
      bottomNavigationBar: SpeechBottomBar(hideTextNotifier: hideTextNotifier),
    );
  }
}
