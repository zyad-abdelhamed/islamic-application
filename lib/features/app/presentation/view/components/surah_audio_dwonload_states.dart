import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/data/models/quran_audio_parameters.dart';
import 'package:test_app/features/app/domain/entities/surah_audio_dwonload_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/download_surah_audio_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/dwonload_icon_with_loading_effect.dart.dart';

class SurahAudioDownloadStates extends StatelessWidget {
  final SurahAudioDownloadEntity? downloadInfo;
  final SurahAudioRequestParams params;
  final TafsirPageController controller;

  const SurahAudioDownloadStates({
    super.key,
    required this.downloadInfo,
    required this.params,
    required this.controller,
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
              controller.getReciters(context, isRefresh: true);

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

          if (state is DeleteSurahAudioFailure) {
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
          final List<int> failedAyahs = downloadInfo?.failedAyahs ?? [];
          final int totalAyahs = controller.surahEntity.numberOfAyat;
          final int downloadedCount = totalAyahs - failedCount;
          final double progress = downloadedCount / totalAyahs.toDouble();

          if (isComplete) {
            return _DeleteSurahAudioButton(
              params: params,
              controller: controller,
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
                    .downloadFailedAyahs(params, failedAyahs),
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

class _DeleteSurahAudioButton extends StatefulWidget {
  final SurahAudioRequestParams params;
  final TafsirPageController controller;

  const _DeleteSurahAudioButton({
    required this.params,
    required this.controller,
  });

  @override
  State<_DeleteSurahAudioButton> createState() =>
      _DeleteSurahAudioButtonState();
}

class _DeleteSurahAudioButtonState extends State<_DeleteSurahAudioButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _handleDelete() async {
    setState(() => _isDeleting = true);
    await _controller.forward();

    if (mounted) {
      await context
          .read<DownloadSurahAudioCubit>()
          .deleteSurahAudio(widget.params);
    }

    if (mounted) {
      widget.controller.getReciters(context, isRefresh: true);
    }

    if (mounted) {
      AppSnackBar(
        message:
            "تم حذف سورة ${widget.params.surahName} بصوت القارئ ${widget.params.reciterName} بنجاح",
        type: AppSnackBarType.success,
      ).show(context);
    }

    setState(() => _isDeleting = false);
    await _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: IconButton(
        icon: Icon(
          Icons.delete_forever,
          color: _isDeleting ? Colors.grey : AppColors.errorColor,
          size: 28,
        ),
        onPressed: _isDeleting ? null : _handleDelete,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
