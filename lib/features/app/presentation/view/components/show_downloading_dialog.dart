import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/download_surah_with_tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/build_delete_surah_dialog.dart';
import 'package:test_app/features/app/presentation/view/components/build_download_surah_dialog.dart';

Future<bool?> showDownloadDialog({
  required BuildContext context,
  required SurahEntity surah,
  required int surahNumber,
}) async {
  final bool? result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return BlocProvider(
        create: (_) => sl<DownloadSurahWithTafsirCubit>(),
        child: BlocBuilder<DownloadSurahWithTafsirCubit,
            DownloadSurahWithTafsirState>(
          builder: (context, state) {
            // لو السورة متحمّلة بالفعل → نعرض ديالوج الحذف
            if (surah.isDownloaded) {
              return buildDeleteDialog(
                context,
                state,
                surah,
                surahNumber,
              );
            }

            //  لو لسه مش متحمّلة → نعرض ديالوج التنزيل
            return buildDownloadDialog(
              context,
              state,
              surah,
              surahNumber,
            );
          },
        ),
      );
    },
  );

  return result; // true لو حصل تنزيل/حذف، false/null لو مفيش
}
