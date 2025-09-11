import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_app/core/constants/cache_constants.dart';
import 'package:test_app/core/constants/data_base_constants.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/features/app/domain/entities/book_mark_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';
import 'package:test_app/features/app/presentation/controller/controllers/quran_page_controller.dart';

part 'quran_state.dart';

class QuranCubit extends HydratedCubit<QuranState> {
  QuranCubit(this.baseQuranRepo) : super(QuranState());
  final BaseQuranRepo baseQuranRepo;

  static QuranCubit getQuranController(BuildContext context) =>
      context.read<QuranCubit>();

  Future<void> loadPdfFromAssets(
      QuranPageController quranPageController) async {
    await quranPageController.loadSurahs();
    final bytes =
        await rootBundle.load(DataBaseConstants.alquranAlkarimPdfPath);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/القران الكريم.pdf');
    await file.writeAsBytes(bytes.buffer.asUint8List());
    emit(state.copyWith(filePath: file.path));
  }

  void goToPageByNumber(QuranPageController quranPageController, int pageNumber,
      List<int> indexs) {
    quranPageController.pdfViewController.setPage(pageNumber);
    emit(state.copyWith(indexs: indexs, defaultPage: pageNumber));
    quranPageController.indexsNotifier.value = indexs.toSet();
  }

  void updateDefaultPage(int? page) => emit(state.copyWith(defaultPage: page));
  void updateIndex(List<int> newValue) =>
      emit(state.copyWith(indexs: newValue));

  @override
  QuranState? fromJson(Map<String, dynamic> json) {
    return QuranState(
        defaultPage: json[CacheConstants.defaultPage], indexs: json["indexs"]);
  }

  @override
  Map<String, dynamic>? toJson(QuranState state) {
    return {
      CacheConstants.defaultPage: state.defaultPage,
      "indexs": state.indexs
    };
  }
}
