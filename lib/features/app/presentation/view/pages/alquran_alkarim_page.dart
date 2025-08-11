import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/quran_page_app_bar_actions.dart';
import 'package:test_app/features/app/presentation/view/components/surahs_widget.dart';

class AlquranAlkarimPage extends StatelessWidget {
  const AlquranAlkarimPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quranCubit = context.read<QuranCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: GetAdaptiveBackButtonWidget(),
        title: FittedBox(
          child: Text(
            AppStrings.appBarTitles(withTwoLines: false)[0],
          ),
        ),
        centerTitle: false,
        actions: quranPageAppBarActions(context),
      ),
      drawer: const Drawer(
        child: SurahsWidget(),
      ),
      body: BlocBuilder<QuranCubit, QuranState>(
        buildWhen: (previous, current) =>
            previous.filePath != current.filePath,
        builder: (context, state) {
          return state.filePath == null
              ? GetAdaptiveLoadingWidget()
              : PDFView(
                  filePath: state.filePath,
                  nightMode: ThemeCubit.controller(context).state,
                  swipeHorizontal: true,
                  pageSnap: true,
                  autoSpacing: true,
                  fitEachPage: true,
                  defaultPage: state.defaultPage,
                  onViewCreated: (controller) =>
                      quranCubit.setPdfController(controller),
                  onRender: (pages) {
                    if (pages != null) {
                      quranCubit.updateTotalPages(pages);
                    }
                  },
                  onPageChanged: (page, total) =>
                      quranCubit.updateDefaultPage(page),
                );
        },
      ),
    );
  }
}

