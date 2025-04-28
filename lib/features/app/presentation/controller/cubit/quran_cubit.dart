import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:test_app/core/constants/data_base_constants.dart';
import 'package:test_app/core/constants/app_strings.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranState());
  static QuranCubit getQuranController(BuildContext context) {
    final QuranCubit controller = context.read<QuranCubit>();
    return controller;
  }

  Future<void> loadPdfFromAssets() async {
    final bytes = await rootBundle.load(DataBaseConstants.alquranAlkarimPdfPath);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/القران الكريم.pdf');

    await file.writeAsBytes(bytes.buffer.asUint8List());

    emit(QuranState(filePath: file.path));
  }
}
