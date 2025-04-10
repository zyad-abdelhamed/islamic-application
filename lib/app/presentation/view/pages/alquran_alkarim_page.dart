import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:test_app/app/presentation/controller/cubit/quran_cubit.dart';
import 'package:test_app/app/presentation/view/components/pages_app_bar.dart';
import 'package:test_app/core/theme/app_colors.dart';

class AlquranAlkarimPage extends StatelessWidget {
  const AlquranAlkarimPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranCubit()..loadPdfFromAssets(),
      child: Scaffold(
          appBar: pagesAppBar[0],
          floatingActionButton: SpeedDial(
            
            backgroundColor: AppColors.primaryColor,
                    animatedIcon: AnimatedIcons.menu_close,

            children: [
             ...List.generate(50, (index) {
             return  SpeedDialChild(
                child: Icon(Icons.arrow_back),
                backgroundColor: AppColors.secondryColor,
                label: 'القران الكريم',
                onTap: () {
              
            });
             },)
              ],
            child: Text('فهرس')

          ),
          body: BlocBuilder<QuranCubit, QuranState>(
            builder: (context, state) {
              return state.filePath == null? Center(child: CircularProgressIndicator()):  PDFView(
                filePath: state.filePath,
                swipeHorizontal: true, 
                pageSnap: true,
                autoSpacing: false,
                fitEachPage: true,
              );
            },
          )),
    );
  }
}
