import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/data/models/tafsir_request_params.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_cubit.dart';

class TafsirPageController {
  late final ScrollController scrollController;
  late final TafsirCubit tafsirCubit;
  late final ValueNotifier<double> fontSizeNotfier;
  void initState(BuildContext context, TafsirRequestParams params) {
    fontSizeNotfier = ValueNotifier(20.0);
    scrollController = ScrollController();
    tafsirCubit = context.read<TafsirCubit>();
    tafsirCubit.getSurahWithTafsir(params);
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final max = scrollController.position.maxScrollExtent;
    final current = scrollController.position.pixels;
    if (current >= max * 0.9) {
      tafsirCubit.loadMore();
    }
  }

  void dispose() {
    scrollController.dispose();
  }
}