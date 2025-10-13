import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_cubit.dart';

class TafsirPageController {
  late final GetSurahWithTafsirCubit tafsirCubit;
  late final ValueNotifier<double> fontSizeNotifier;
  late final ValueNotifier<bool> isShowed;
  late final ValueNotifier<int?> selectedAyah;
  late final GlobalKey infoKey;

  late final TafsirRequestParams tafsirRequestParams;
  late final SurahRequestParams surahParams;
  late final SurahEntity surahEntity;

  TafsirPageController(
    BuildContext context, {
    required this.tafsirRequestParams,
    required this.surahParams,
    required this.surahEntity,
  }) {
    infoKey = GlobalKey();
    fontSizeNotifier = ValueNotifier(25.0);
    isShowed = ValueNotifier<bool>(false);
    selectedAyah = ValueNotifier<int?>(null);
    tafsirCubit = context.read<GetSurahWithTafsirCubit>();
    tafsirCubit.getSurahWithTafsir(
        surahRequestParams: surahParams,
        tafsirRequestParams: tafsirRequestParams);
  }

  void toggleTopBar() => isShowed.value = !isShowed.value;

  void hideHighlight() => selectedAyah.value = null;

  void dispose() {
    fontSizeNotifier.dispose();
    isShowed.dispose();
    selectedAyah.dispose();
  }
}
