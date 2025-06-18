import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_cubit.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/presentation/view/components/surahs_widget.dart';

class AlquranAlkarimPage extends StatelessWidget {
  const AlquranAlkarimPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GetAdaptiveBackButtonWidget(),
          title: Text(AppStrings.appBarTitles(withTwoLines: false)[0]),
          actions: [
            Builder(builder: (context) {
              return TextButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  child: Text(
                    AppStrings.theIndex,
                    style: TextStyles.semiBold16_120(context).copyWith(
                        color: ThemeCubit.controller(context).state
                            ? AppColors.white
                            : AppColors.black),
                  ));
            })
          ],
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
                      nightMode: context.watch<ThemeCubit>().state,
                      swipeHorizontal: true,
                      pageSnap: true,
                      autoSpacing: true,
                      fitEachPage: true,
                      defaultPage: state.defaultPage,
                      onViewCreated: (controller) =>
                          QuranCubit.getQuranController(context)
                              .setPdfController(controller),
                      onRender: (pages) {
                        if (pages != null) {
                          QuranCubit.getQuranController(context)
                              .updateTotalPages(pages);
                        }
                      },
                      onPageChanged: (page, total) =>
                          QuranCubit.getQuranController(context)
                              .updateDefaultPage(page),
                    );
            }));
  }
}
