import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/utils/status_bar_utils.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_cubit.dart';

class TafsirPageController {
  late final GetSurahWithTafsirCubit tafsirCubit;
  late final ValueNotifier<double> fontSizeNotifier;
  late final ValueNotifier<bool> isShowed;
  late final ValueNotifier<int?> selectedAyah;
  late final GlobalKey infoKey;

  void initState(BuildContext context, TafsirRequestParams params,
      SurahRequestParams surahRequestParams) {
    StatusBarUtils.hide();
    infoKey = GlobalKey();
    fontSizeNotifier = ValueNotifier(25.0);
    isShowed = ValueNotifier<bool>(false);
    selectedAyah = ValueNotifier<int?>(null);
    tafsirCubit = context.read<GetSurahWithTafsirCubit>();
    tafsirCubit.getSurahWithTafsir(
        surahRequestParams: surahRequestParams, tafsirRequestParams: params);
  }

  void toggleTopBar() => isShowed.value = !isShowed.value;

  void hideHighlight() => selectedAyah.value = null;

  void dispose() {
    StatusBarUtils.show();
    fontSizeNotifier.dispose();
    isShowed.dispose();
    selectedAyah.dispose();
  }
}
