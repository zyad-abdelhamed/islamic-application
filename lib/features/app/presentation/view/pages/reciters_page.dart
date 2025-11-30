import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/widgets/custom_scaffold.dart';
import 'package:test_app/features/app/presentation/controller/controllers/tafsir_page_controller.dart';
import 'package:test_app/features/app/presentation/view/components/reciter_widget.dart';

class RecitersPage extends StatelessWidget {
  final TafsirPageController controller;
  const RecitersPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: AppBar(
          leading:
              const GetAdaptiveBackButtonWidget(backBehavior: BackBehavior.pop),
          title: Text(
            'القرّاء',
            style: TextStyles.semiBold32(context,
                color: Theme.of(context).primaryColor),
          ),
        ),
        body: ValueListenableBuilder(
            valueListenable: controller.recitersNotifier,
            builder: (context, value, child) {
              return value != null
                  ? ListView.builder(
                      itemCount: controller.recitersNotifier.value!.length,
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (context, index) {
                        return ReciterCardWidget(
                          reciter: value[index],
                          controller: controller,
                        );
                      },
                    )
                  : const Center(
                      child: AppLoadingWidget(),
                    );
            }));
  }
}
