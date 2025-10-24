import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/download_surah_with_tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/show_reciters_selection_dialog.dart';

Widget buildDownloadDialog(
  BuildContext context,
  DownloadSurahWithTafsirState state,
  SurahEntity surah,
  int surahNumber,
) {
  if (state is DownloadSurahWithTafsirLoading) {
    return AlertDialog(
      title: const Text('جاري التنزيل...'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset('assets/animations/download.json', repeat: true),
          Text(
            'جاري تنزيل سورة "${surah.name}"...\n\nيرجى عدم إغلاق التطبيق.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  } else if (state is DownloadSurahWithTafsirSuccess) {
    return AlertDialog(
      title: const Text('تم التنزيل'),
      content: Column(
        spacing: 5.0,
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset('assets/animations/File downloaded.json', repeat: true),
          Text(
            'تم تنزيل سورة "${surah.name}" بنجاح وهي متاحة الآن بلا إنترنت.',
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
  } else if (state is DownloadSurahWithTafsirError) {
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
  // initial state
  return AlertDialog(
    title: const Text('تنزيل السورة'),
    content: Text(
      'هل تريد تنزيل سورة "${surah.name}" لتكون متاحة بلا إنترنت؟',
      textAlign: TextAlign.center,
    ),
    actionsAlignment: MainAxisAlignment.start,
    actions: [
      ElevatedButton.icon(
        icon: const Icon(Icons.download_for_offline),
        label: const Text('تنزيل'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlueAccent,
          foregroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
        ),
        onPressed: () {
          showRecitersSelectionDialog(
            context: context,
            desc: 'يمكنك اختيار قراء لتنزيل الصوت للسورة',
            onConfirm: (List<ReciterEntity> selectedReciters) => context
                .read<DownloadSurahWithTafsirCubit>()
                .downloadSurahWithTafsir(
                  tafsirRequestParams: TafsirRequestParams(
                    surah: surah,
                    surahNumber: surahNumber,
                    limit: surah.numberOfAyat,
                  ),
                  surahRequestParams: SurahRequestParams(
                    surah: surah,
                    surahNumber: surahNumber,
                    limit: surah.numberOfAyat,
                  ),
                  selectedReciters: selectedReciters,
                ),
          );
        },
      ),
      TextButton(
        onPressed: () => Navigator.of(context).pop(false),
        child: const Text('إلغاء'),
      ),
    ],
  );
}
