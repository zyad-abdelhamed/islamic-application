import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/core/constants/data_base_constants.dart';
import 'package:test_app/core/constants/app_strings.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranState());

  static QuranCubit getQuranController(BuildContext context) =>
      context.read<QuranCubit>();

  late PDFViewController _pdfViewController;
  int totalPages = 0;
  void changeCIndex(int index) {
    emit(state.copyWith(cIndex: index));
  }

  void setPdfController(PDFViewController controller) {
    _pdfViewController = controller;
  }

  void updateTotalPages(int pages) {
    totalPages = pages;
  }

  Future<void> loadPdfFromAssets() async {
    final bytes =
        await rootBundle.load(DataBaseConstants.alquranAlkarimPdfPath);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/القران الكريم.pdf');
    await file.writeAsBytes(bytes.buffer.asUint8List());
    emit(state.copyWith(filePath: file.path));
  }

  void goToPageByNumber(int pageNumber) {
    print('Requested page: $pageNumber, Total pages: $totalPages');

    if (pageNumber >= 0 && pageNumber < totalPages) {
      _pdfViewController.setPage(pageNumber);
      emit(state.copyWith());
    } else {
      print('Page request out of range!');
    }
  }

  void goToPageBySurah(String surahName) {
    if (AppStrings.surahPages.containsKey(surahName)) {
      final page = AppStrings.surahPages[surahName]! - 1; // zero-based index
      goToPageByNumber(page);
    }
  }

  void showOrHideIndex(BuildContext context) {
    if (state.height == 0.0) {
      emit(state.copyWith(
        width: 160,
        height: context.height * .60,
        floatingActionButtonString: 'X',
      ));
    } else {
      emit(state.copyWith(
        width: 0.0,
        height: 0.0,
        floatingActionButtonString: 'الفهرس',
      ));
    }
  }
}
