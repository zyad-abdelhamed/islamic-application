import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_state.dart';
import 'package:test_app/features/app/presentation/view/components/controle_font_size_buttons.dart';
import 'package:test_app/features/app/presentation/view/components/erorr_widget.dart';
import 'package:test_app/features/app/presentation/view/components/get_surah_with_tafsir_sucsess_state_view.dart';

class TafsirPage extends StatefulWidget {
  final TafsirRequestParams tafsirRequestParams;
  final SurahRequestParams surahParams;

  const TafsirPage({
    super.key,
    required this.tafsirRequestParams,
    required this.surahParams,
  });

  @override
  State<TafsirPage> createState() => _TafsirPageState();
}

class _TafsirPageState extends State<TafsirPage> {
  late final TafsirPageController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TafsirPageController();
    _controller.initState(
      context,
      widget.tafsirRequestParams,
      widget.surahParams,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تفسير سورة ${widget.tafsirRequestParams.surahName}',
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
      body: BlocBuilder<GetSurahWithTafsirCubit, GetSurahWithTafsirState>(
          builder: (context, state) {
        if (state is GetSurahWithTafsirLoading) {
          return const Center(child: GetAdaptiveLoadingWidget());
        } else if (state is GetSurahWithTafsirFailure) {
          return ErrorWidgetIslamic(
            message: state.message,
            buttonWidget: Text(AppStrings.translate("tryAgain")),
            onPressed: () => _controller.tafsirCubit.retry(),
          );
        } else if (state is GetSurahWithTafsirSuccess) {
          return GetSurahWithTafsirSuccessStateView(
            state: state,
            controller: _controller,
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
