import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/data/models/tafsir_request_params.dart';
import 'package:test_app/features/app/presentation/controller/cubit/cubit/get_surah_with_tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/cubit/get_surah_with_tafsir_state.dart';
import 'package:test_app/features/app/presentation/view/components/tafsir_ayah_widget.dart';

class TafsirPage extends StatefulWidget {
  final TafsirRequestParams params;

  const TafsirPage({
    super.key,
    required this.params,
  });

  @override
  State<TafsirPage> createState() => _TafsirPageState();
}

class _TafsirPageState extends State<TafsirPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<TafsirCubit>().getSurahWithTafsir(widget.params);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final max = _scrollController.position.maxScrollExtent;
    final current = _scrollController.position.pixels;
    if (current >= max * 0.9) {
      context.read<TafsirCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeCubit.controller(context).state;

    final Color cardColor = isDark ? AppColors.darkModePrimaryColor : AppColors.white;
    final Color textColor = isDark ? AppColors.darkModeTextColor : AppColors.lightModeTextColor;
    final Color ayahNumberColor = isDark ? AppColors.darkModeTextColor : AppColors.lightModePrimaryColor;
    final Color backgroundColor = isDark ? const Color(0xFF121212) : const Color(0xFFF7F7F7);
   
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تفسير ${widget.params.surahName}',
        ),
      ),
      backgroundColor: backgroundColor,
      body: BlocBuilder<TafsirCubit, TafsirState>(
        builder: (context, state) {
          if (state is TafsirLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TafsirError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: AppColors.errorColor),
              ),
            );
          } else if (state is TafsirLoaded) {
            final items = state.tafsir;

            return ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: items.length + (state.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < items.length) {
                  final ayah = items[index];

                  return TafsirAyahWidget(
                    ayah: ayah,
                    cardColor: cardColor,
                    ayahNumberColor: ayahNumberColor,
                    textColor: textColor,
                    isDark: isDark,
                  );

                } else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
