import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:test_app/core/utils/responsive_extention.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranState());
  static QuranCubit getQuranController(BuildContext context) {
    final QuranCubit controller = context.read<QuranCubit>();
    return controller;
  }

  Future<void> loadPdfFromAssets() async {
    final bytes = await rootBundle.load('assets/pdfs/القران الكريم.pdf');
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/القران الكريم.pdf');

    await file.writeAsBytes(bytes.buffer.asUint8List());

    emit(QuranState(filePath: file.path));
  }

  void showOrHideIndex(BuildContext context) {
    if (state.height == 0.0) {
      emit(QuranState(
          width: 160,
          height: context.height * .60,
          floatingActionButtonString: 'X',
          filePath: state.filePath));
    } else {
      emit(QuranState(filePath: state.filePath));
    }
  }
}
