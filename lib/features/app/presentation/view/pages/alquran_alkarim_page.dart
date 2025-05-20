import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_cubit.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/presentation/view/components/surahs_widget.dart';

class AlquranAlkarimPage extends StatelessWidget {
  const AlquranAlkarimPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(AppStrings.appBarTitles(withTwoLines: false)[0])),
        drawer: const Drawer(
          backgroundColor: AppColors.primaryColor,
          shape: LinearBorder(),
          child: SurahsWidget(),
        ),
        body: BlocSelector<QuranCubit, QuranState, String?>(
            selector: (state) => state.filePath,
            builder: (context, filePath) {
              print("rebuild Alquran Alkarim Page");
              return filePath == null
                  ? GetAdaptiveLoadingWidget()
                  : PDFView(
                      filePath: filePath,
                      nightMode: context.themeController.darkMode,
                      swipeHorizontal: true,
                      pageSnap: true,
                      autoSpacing: true,
                      fitEachPage: true,
                      defaultPage: 0,
                      onViewCreated: (controller) {
                        QuranCubit.getQuranController(context)
                            .setPdfController(controller);
                      },
                      onRender: (pages) {
                        if (pages != null) {
                          QuranCubit.getQuranController(context)
                              .updateTotalPages(pages);
                        }
                      },
                    );
            }));
  }
}
