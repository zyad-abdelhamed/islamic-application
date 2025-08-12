import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/controller/controllers/quran_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/quran_page_app_bar_actions.dart';
import 'package:test_app/features/app/presentation/view/components/surahs_widget.dart';

class AlquranAlkarimPage extends StatefulWidget {
  const AlquranAlkarimPage({super.key});

  @override
  State<AlquranAlkarimPage> createState() => _AlquranAlkarimPageState();
}

class _AlquranAlkarimPageState extends State<AlquranAlkarimPage> {
  late final QuranPageController _quranPageController;

  @override
  void initState() {
    _quranPageController =
    QuranPageController();
    _quranPageController.initState();
    QuranCubit.getQuranController(context)
        .loadPdfFromAssets(_quranPageController);
    super.initState();
  }

  @override
  void dispose() {
    _quranPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GetAdaptiveBackButtonWidget(),
        title: FittedBox(
          child: Text(
            AppStrings.appBarTitles(withTwoLines: false)[0],
          ),
        ),
        centerTitle: false,
        actions: quranPageAppBarActions(context, _quranPageController),
      ),
      drawer: Drawer(
        child: SurahsWidget(quranPageController: _quranPageController),
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
                  onViewCreated: (controller) {
                      _quranPageController.setPdfController(controller);
                      _quranPageController.indexsNotifier.value = state.indexs;
                  },
                  onPageChanged: (page, total) {
                      QuranCubit.getQuranController(context).updateDefaultPage(page);
                      _quranPageController.updateIndexNotifier(context, page ?? 0);
                  },
                );
        },
      ),
    );
  }
}

