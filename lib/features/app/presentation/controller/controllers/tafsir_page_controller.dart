import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_cubit.dart';

class TafsirPageController {
  late final GetSurahWithTafsirCubit tafsirCubit;
  late final ValueNotifier<double> fontSizeNotfier;

  void initState(BuildContext context, TafsirRequestParams params,
      SurahRequestParams surahRequestParams) {
    fontSizeNotfier = ValueNotifier(20.0);
    tafsirCubit = context.read<GetSurahWithTafsirCubit>();
    tafsirCubit.getSurahWithTafsir(
        surahRequestParams: surahRequestParams, tafsirRequestParams: params);
  }

  void dispose() {
    fontSizeNotfier.dispose();
  }
}
