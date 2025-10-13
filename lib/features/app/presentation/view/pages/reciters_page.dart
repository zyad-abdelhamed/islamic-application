import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/reciters_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/erorr_widget.dart';
import 'package:test_app/features/app/presentation/view/components/reciter_widget.dart';

class RecitersPage extends StatelessWidget {
  final TafsirPageController controller;
  const RecitersPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecitersCubit(sl())
        ..getReciters(surahName: controller.surahParams.surah.name),
      child: Scaffold(
        appBar: AppBar(
          leading:
              const GetAdaptiveBackButtonWidget(backBehavior: BackBehavior.pop),
          title: Text(
            'القرّاء',
            style: TextStyles.semiBold32(context,
                color: Theme.of(context).primaryColor),
          ),
        ),
        body: BlocBuilder<RecitersCubit, RecitersState>(
          builder: (context, state) {
            if (state is RecitersFailure) {
              return ErrorWidgetIslamic(message: state.message);
            } else if (state is RecitersLoading) {
              return SizedBox.shrink();
            } else if (state is RecitersLoaded) {
              return ListView.builder(
                itemCount: state.reciters.length,
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (context, index) {
                  return ReciterCardWidget(
                    reciter: state.reciters[index],
                    controller: controller,
                  );
                },
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
