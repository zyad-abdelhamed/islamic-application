import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_app/core/constants/cache_constants.dart';
import 'package:test_app/core/constants/data_base_constants.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/features/app/domain/entities/book_mark_entity.dart';
import 'package:test_app/features/app/domain/repositories/base_quran_repo.dart';

part 'quran_state.dart';

class QuranCubit extends HydratedCubit<QuranState> {
  QuranCubit(this.baseQuranRepo) : super(QuranState());
  final BaseQuranRepo baseQuranRepo;

  static QuranCubit getQuranController(BuildContext context) =>
      context.read<QuranCubit>();

  late PDFViewController _pdfViewController;
  int totalPages = 0;

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

  void goToPageByNumber(int pageNumber, int index) {
    if (pageNumber >= 0 && pageNumber < totalPages) {
      _pdfViewController.setPage(pageNumber);
      emit(state.copyWith(cIndex: index, defaultPage: pageNumber));
    }
  }

  void updateDefaultPage(int? page) => emit(state.copyWith(defaultPage: page));

  @override
  QuranState? fromJson(Map<String, dynamic> json) {
    return QuranState(defaultPage: json[CacheConstants.defaultPage]);
  }

  @override
  Map<String, dynamic>? toJson(QuranState state) {
    return {CacheConstants.defaultPage: state.defaultPage};
  }

  saveBookMarks() async {
    final result = await baseQuranRepo.saveBookMark(
        bookmarkentity: BookMarkEntity(title: 'ddf', pageNumber: 9));
    result.fold((l) {
      //////حالة الفشل
    }, (r) {
      /////حالة النجاح
    });
  }

  getBookMarks() async {
    final result = await baseQuranRepo.getBookMarks();
    result.fold((l) {
      emit(state.copyWith(
          bookMarkState: RequestStateEnum.failed,
          messageOfbookmarkFailure: l.message));
    }, (r) {
      emit(state.copyWith(
          bookMarks: r, bookMarkState: RequestStateEnum.success));
    });
  }

  deleteBookMarks({required int index}) async {
    final result = await baseQuranRepo.deleteBookMark(index: index);
    result.fold((l) {
      //////حالة الفشل
    }, (r) {
      /////حالة النجاح
    });
  }

  clearBookMarks() async {
    final result = await baseQuranRepo.clearBookMarks();
    result.fold((l) {
      //////حالة الفشل
    }, (r) {
      /////حالة النجاح
    });
  }
}
