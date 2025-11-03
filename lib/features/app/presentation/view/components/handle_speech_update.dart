import 'package:flutter/material.dart';
import 'package:test_app/features/app/domain/entities/ayah_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/speech_cubit.dart';

class SpeechHandler {
  static void handleSpeechUpdate({
    required SpeechUpdated state,
    required SpeechCubit cubit,
    required List<AyahEntity> ayat,
    required ValueNotifier<String> displayedTextNotifier,
    required ValueNotifier<Map<int, int>> ayahProgressNotifier,
    required ValueNotifier<int?> selectedAyahNotifier,
    required ValueNotifier<String?> effectNotifier,
    required bool mounted,
    required void Function(void Function()) setState,
    required String lastSpokenWord,
  }) {
    final spoken = state.spokenText.trim();
    if (spoken.isEmpty) return;

    final words = spoken.split(" ");
    final newWord = words.last;
    if (newWord == lastSpokenWord) return;

    displayedTextNotifier.value = words.length >= 2
        ? "${words[words.length - 2]} ${words.last}"
        : words.last;

    final ayahNum = selectedAyahNotifier.value;
    if (ayahNum == null) return;

    final ayahText = ayat.firstWhere((a) => a.number == ayahNum).text;
    final ayahWords = ayahText.split(" ");
    final currentProgress = ayahProgressNotifier.value[ayahNum] ?? 0;

    if (currentProgress >= ayahWords.length) return;

    final targetWord = ayahWords[currentProgress];
    final similarity = cubit.calculateSimilarity(targetWord, newWord);

    if (similarity >= 0.7) {
      final updatedMap = Map<int, int>.from(ayahProgressNotifier.value);
      updatedMap[ayahNum] = currentProgress + 1;
      ayahProgressNotifier.value = updatedMap;

      effectNotifier.value = 'correct';
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted && effectNotifier.value == 'correct') {
          effectNotifier.value = null;
        }
      });

      if (updatedMap[ayahNum]! >= ayahWords.length) {
        final idx = ayat.indexWhere((a) => a.number == ayahNum);
        if (idx < ayat.length - 1) {
          selectedAyahNotifier.value = ayat[idx + 1].number;
        }
      }
    } else if (similarity > 0.3) {
      effectNotifier.value = 'error';
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted && effectNotifier.value == 'error') {
          effectNotifier.value = null;
        }
      });
    }
  }
}
