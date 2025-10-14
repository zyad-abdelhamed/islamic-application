import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_cubit.dart';

class TafsirPageController {
  late final GetSurahWithTafsirCubit tafsirCubit;
  late final ValueNotifier<double> fontSizeNotifier;
  late final ValueNotifier<bool> isShowed;
  late final ValueNotifier<int?> selectedAyah;
  late final ValueNotifier<List<ReciterEntity>?> recitersNotifier;
  late final ValueNotifier<ReciterEntity?> currentReciterNotifier;
  late final ValueNotifier<bool> isAudioPlayingNotifier;
  late final Stream<double> audioPositionStream;
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
    recitersNotifier = ValueNotifier<List<ReciterEntity>?>(null);
    currentReciterNotifier = ValueNotifier<ReciterEntity?>(null);
    isAudioPlayingNotifier = ValueNotifier<bool>(false);
    audioPositionStream = const Stream<double>.empty();
    tafsirCubit = context.read<GetSurahWithTafsirCubit>();
    tafsirCubit.getSurahWithTafsir(
        surahRequestParams: surahParams,
        tafsirRequestParams: tafsirRequestParams);

    getReciters(context);
  }

  void getReciters(BuildContext context) async {
    final Either<Failure, List<ReciterEntity>> result =
        await sl<BaseQuranRepo>().getReciters(surahName: surahEntity.name);
    result.fold(
      (Failure l) =>
          AppSnackBar(message: l.message, type: AppSnackBarType.error)
              .show(context),
      (List<ReciterEntity> reciters) => recitersNotifier.value = reciters,
    );
  }

  void toggleTopBar() => isShowed.value = !isShowed.value;

  void hideHighlight() => selectedAyah.value = null;

  void dispose() {
    fontSizeNotifier.dispose();
    isShowed.dispose();
    selectedAyah.dispose();
  }
}
