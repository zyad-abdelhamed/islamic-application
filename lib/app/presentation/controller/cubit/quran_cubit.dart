import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranState());
  Future<void> loadPdfFromAssets() async {
    final bytes = await rootBundle.load('assets/pdfs/القران الكريم.pdf');
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/القران الكريم.pdf');

    await file.writeAsBytes(bytes.buffer.asUint8List());

    emit(QuranState(filePath: file.path));
  }
}
