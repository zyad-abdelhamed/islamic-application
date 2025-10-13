import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/data/models/quran_audio_parameters.dart';
import 'package:test_app/features/app/domain/entities/surah_audio_dwonload_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/download_surah_audio_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/dwonload_icon_with_loading_effect.dart.dart';

class SurahAudioDownloadStates extends StatelessWidget {
  final SurahAudioDownloadEntity? downloadInfo;
  final SurahAudioRequestParams params;
  final int totalAyahs;

  const SurahAudioDownloadStates({
    super.key,
    required this.downloadInfo,
    required this.params,
    required this.totalAyahs,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DownloadSurahAudioCubit>(
      create: (_) => sl<DownloadSurahAudioCubit>(),
      child: BlocConsumer<DownloadSurahAudioCubit, DownloadSurahAudioState>(
        listener: (context, state) {
          if (state is DownloadSurahAudioSuccess) {
            final bool isComplete = state.failedAyahs.isEmpty;

            if (isComplete) {
              AppSnackBar(
                message:
                    "تم تنزيل سورة ${params.surahName} بصوت القارئ ${params.reciterName} بنجاح",
                type: AppSnackBarType.success,
              ).show(context);
            } else {
              AppSnackBar(
                message:
                    "تم تحميل جزئي (${state.failedAyahs.length} آيات فشلت). يمكنك محاولة استكمال التنزيل لاحقًا.",
                type: AppSnackBarType.error,
              ).show(context);
            }
          }

          if (state is DownloadSurahAudioFailure) {
            AppSnackBar(
              message: state.message,
              type: AppSnackBarType.error,
            ).show(context);
          }
        },
        builder: (context, state) {
          final bool isLoading = state is DownloadSurahAudioLoading;
          final bool isComplete =
              downloadInfo?.status == SurahAudioDownloadStatus.complete;
          final bool isPartial =
              downloadInfo?.status == SurahAudioDownloadStatus.partial;
          final int failedCount = downloadInfo?.failedAyahs.length ?? 0;
          final int downloadedCount = totalAyahs - failedCount;
          final double progress = downloadedCount / totalAyahs.toDouble();

          if (isComplete) {
            return const Icon(
              Icons.check_circle,
              color: AppColors.successColor,
              size: 28,
            );
          }

          return Column(
            spacing: 5,
            mainAxisSize: MainAxisSize.min,
            children: [
              DownloadIconWithLoadingEffect(
                isLoading: isLoading,
                onPressed: () => context
                    .read<DownloadSurahAudioCubit>()
                    .downloadSurah(params),
              ),
              if (isPartial)
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: AppColors.successColor,
                ),
            ],
          );
        },
      ),
    );
  }
}
