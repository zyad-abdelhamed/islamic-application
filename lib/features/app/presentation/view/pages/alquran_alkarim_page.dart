import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_cubit.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/view/components/parts_widget.dart';

class AlquranAlkarimPage extends StatelessWidget {
  const AlquranAlkarimPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => QuranCubit()..loadPdfFromAssets(),
        child: BlocBuilder<QuranCubit, QuranState>(
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  leading: GetAdaptiveBackButtonWidget(),
                  title: Text(AppStrings.appBarTitles(withTwoLines: false)[0]),
                ),
                floatingActionButton: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: GestureDetector(
                      onTap: () {
                        QuranCubit.getQuranController(context)
                            .showOrHideIndex(context);
                      },
                      child: CircleAvatar(
                          radius: 35,
                          backgroundColor: AppColors.primaryColor,
                          child: Text(
                            state.floatingActionButtonString,
                            textAlign: TextAlign.center,
                            style: TextStyles.bold20(context)
                                .copyWith(color: AppColors.white),
                          )),
                    ),
                  ),
                ),
                body: Stack(
                  children: [
                    state.filePath == null
                        ? Center(child: CircularProgressIndicator())
                        : PDFView(
                            filePath: state.filePath,
                            swipeHorizontal: true,
                            pageSnap: true,
                            autoSpacing: false,
                            fitEachPage: true,
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
                          ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: PartsWidget(
                        height: state.height,
                        width: state.width,
                      ),
                    ),
                  ],
                ));
          },
        ));
  }
}
