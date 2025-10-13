import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/data/models/quran_request_params.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_state.dart';
import 'package:test_app/features/app/presentation/view/components/erorr_widget.dart';
import 'package:test_app/features/app/presentation/view/components/get_surah_with_tafsir_sucsess_state_view.dart';
import 'package:test_app/features/app/presentation/view/components/tafsir_page_over_layout.dart';

class TafsirPage extends StatefulWidget {
  final TafsirRequestParams tafsirRequestParams;
  final SurahRequestParams surahParams;
  final SurahEntity surahEntity;

  const TafsirPage({
    super.key,
    required this.tafsirRequestParams,
    required this.surahParams,
    required this.surahEntity,
  });

  @override
  State<TafsirPage> createState() => _TafsirPageState();
}

class _TafsirPageState extends State<TafsirPage> {
  late final TafsirPageController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TafsirPageController(
      context,
      tafsirRequestParams: widget.tafsirRequestParams,
      surahParams: widget.surahParams,
      surahEntity: widget.surahEntity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => _controller,
      child: Scaffold(
        body: Stack(
          children: [
            BlocBuilder<GetSurahWithTafsirCubit, GetSurahWithTafsirState>(
                builder: (context, state) {
              if (state is GetSurahWithTafsirLoading) {
                return const Center(child: AppLoadingWidget());
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
            // Overlay جديد ب GestureDetector
            Positioned.fill(
              child: GestureDetector(
                behavior:
                    HitTestBehavior.translucent, // يسمح بمرور longPress للي تحت
                onDoubleTap: _controller.toggleTopBar, // toggle للتوب بار
                child: const SizedBox.expand(), // يملأ الشاشة كلها
              ),
            ),

            ValueListenableBuilder<bool>(
              valueListenable: _controller.isShowed,
              builder: (context, visible, child) {
                return TafsirPageOverLayout(
                    widget: widget, controller: _controller);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
