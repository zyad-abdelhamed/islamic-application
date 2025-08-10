import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/core/widgets/empty_list_text_widget.dart';
import 'package:test_app/features/app/data/models/tafsir_request_params.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_state.dart';
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
  late final ScrollController _scrollController;
  late final TafsirCubit _tafsirCubit;
  @override
  void initState() {
    _scrollController = ScrollController();
    _tafsirCubit = context.read<TafsirCubit>();
    _tafsirCubit.getSurahWithTafsir(widget.params);
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    final max = _scrollController.position.maxScrollExtent;
    final current = _scrollController.position.pixels;
    if (current >= max * 0.9) {
      _tafsirCubit.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeCubit.controller(context).state;
    final Color? textColor = isDark ? AppColors.grey400 : Colors.black;
    final Color ayahNumberColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تفسير سورة ${widget.params.surahName}',
        ),
      ),
      body: BlocBuilder<TafsirCubit, TafsirState>(
        builder: (context, state) {
          if (state is TafsirLoading) {
            return const Center(child: GetAdaptiveLoadingWidget());
          } else if (state is TafsirError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: AppColors.errorColor),
              ),
            );
          } else if (state is TafsirLoaded) {
            final items = state.tafsir;

            if (items.isEmpty) {
              return EmptyListTextWidget(
                text: AppStrings.translate("noTafsirAvailable"),
              );
            }

            return ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: items.length + (state.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < items.length) {
                  final ayah = items[index];
                  return TafsirAyahWidget(
                    ayah: ayah,
                    ayahNumberColor: ayahNumberColor,
                    textColor: textColor ?? Colors.grey,
                    isDark: isDark,
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: GetAdaptiveLoadingWidget(),
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
