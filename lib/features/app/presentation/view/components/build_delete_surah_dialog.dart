import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/download_surah_with_tafsir_cubit.dart';

Widget buildDeleteDialog(
  BuildContext context,
  DownloadSurahWithTafsirState state,
  SurahEntity surah,
  int surahNumber,
) {
  if (state is DeleteSurahWithTafsirLoading) {
    return AlertDialog(
      title: const Text('جارٍ الحذف...'),
      content: Text('جاري حذف سورة "${surah.name}" من التنزيلات.'),
    );
  } else if (state is DeleteSurahWithTafsirSuccess) {
    return AlertDialog(
      title: const Text('تم الحذف'),
      content: Column(
        spacing: 5.0,
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset('assets/animations/Deleted.json', repeat: true),
          Text(
            'تم حذف سورة "${surah.name}" من التنزيلات.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.start,
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('إغلاق'),
        ),
      ],
    );
  } else if (state is DeleteSurahWithTafsirError) {
    return AlertDialog(
      title: const Text('خطأ'),
      content: Text(state.message),
      actionsAlignment: MainAxisAlignment.start,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('حسناً'),
        ),
      ],
    );
  }

  return AlertDialog(
    title: const Text('حذف السورة'),
    content: Text(
      'سورة "${surah.name}" تم تنزيلها مسبقًا.\nهل تريد حذفها من التنزيلات؟',
      textAlign: TextAlign.center,
    ),
    actionsAlignment: MainAxisAlignment.start,
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(false),
        child: const Text('إلغاء'),
      ),
      ElevatedButton.icon(
        icon: const Icon(Icons.delete_forever),
        label: const Text('حذف'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        onPressed: () {
          context.read<DownloadSurahWithTafsirCubit>().deleteSurahWithTafsir(
                key: surah.name,
              );
        },
      ),
    ],
  );
}
