import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/core/widgets/empty_list_text_widget.dart';
import 'package:test_app/features/app/data/models/tafsir_request_params.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_state.dart';
import 'package:test_app/features/app/presentation/view/components/controle_font_size_buttons.dart';
import 'package:test_app/features/app/presentation/view/components/erorr_widget.dart';
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
  late final TafsirPageController _controller;
  @override
  void initState() {
    _controller = TafsirPageController();
    _controller.initState(context, widget.params);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeCubit.controller(context).state;
    final Color textColor = Colors.brown;
    final Color backgroundColor = isDark
        ? AppColors.darkModeInActiveColor
        : AppColors.lightModeInActiveColor;
    final Color ayahNumberColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تفسير سورة ${widget.params.surahName}',
        ),
        centerTitle: false,
        actions: [
          ControleFontSizeButtons(
            fontSizeNotfier: _controller.fontSizeNotfier,
            initialFontSize: 20,
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: BlocBuilder<TafsirCubit, TafsirState>(
        builder: (context, state) {
          if (state is TafsirLoading) {
            return const Center(child: GetAdaptiveLoadingWidget());
          } else if (state is TafsirError) {
            return ErrorWidgetIslamic(message: state.message);
          } else if (state is TafsirLoaded) {
            final items = state.tafsir;

            if (items.isEmpty) {
              return EmptyListTextWidget(
                text: AppStrings.translate("noTafsirAvailable"),
              );
            }

            return ListView.builder(
              controller: _controller.scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: items.length + (state.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < items.length) {
                  final ayah = items[index];
                  return TafsirAyahWidget(
                    controller: _controller,
                    ayah: ayah,
                    ayahNumberColor: ayahNumberColor,
                    textColor: textColor,
                    backgroundColor: backgroundColor,
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
    _controller.dispose();
    super.dispose();
  }
}
