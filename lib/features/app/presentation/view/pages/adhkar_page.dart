import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/features/app/data/models/adhkar_parameters.dart';
import 'package:test_app/features/app/presentation/controller/cubit/supplications_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/circle_painter.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_widget.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_page_app_bar.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';
import 'package:test_app/core/helper_function/get_widget_depending_on_reuest_state.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class AdhkarPage extends StatelessWidget {
  final String nameOfAdhkar;
  const AdhkarPage({super.key, required this.nameOfAdhkar});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AdhkarCubit(sl())
          ..getAdhkar(
              AdhkarParameters(nameOfAdhkar: nameOfAdhkar, context: context)),
        child: Scaffold(
            appBar: adhkarPageAppBar(context, appBarTitle: nameOfAdhkar),
            body: BlocBuilder<AdhkarCubit, AdhkarState>(
                buildWhen: (previous, current) =>
                    previous.isDeleted ==
                    current.isDeleted, //to avoid rebuild when change switch
                builder: (context, state) {
                  print('rebuild adhkar page body');
                  return Stack(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: getWidgetDependingOnReuestState(
                          requestStateEnum: state.adhkarRequestState,
                          widgetIncaseSuccess: ListView.builder(
                              controller: context.supplicationsController
                                  .supplicationsScrollController,
                              itemCount: state.adhkar.length,
                              itemBuilder: (context, index) =>
                                  AdhkarWidget(
                                    index: index,
                                    adhkarEntity: state.adhkar[index],
                                    state: state,
                                  )),
                          erorrMessage: state.adhkarErorrMessage),
                    ),

                    //circle slider
                    _getCustomCircleSlider(context,
                        customPainter: CirclePainter(
                            lineSize: 5.0,
                            progress: _getMaxProgress(context),
                            context: context,
                            lineColor: AppColors.inActiveThirdColor,
                            maxProgress: _getMaxProgress(context))),

                    _getCustomCircleSlider(context,
                        customPainter: CirclePainter(
                            lineSize: 5.0,
                            progress: state.progress,
                            context: context,
                            lineColor: AppColors.thirdColor,
                            maxProgress: _getMaxProgress(context)))
                  ]);
                })));
  }
}

Positioned _getCustomCircleSlider(BuildContext context,
    {required CustomPainter customPainter}) {
  return Positioned(
    bottom: 20.0,
    left: 20.0,
    child: AnimatedOpacity(
      duration: AppDurations.mediumDuration,
      opacity: context
              .supplicationsController.supplicationsScrollController.hasClients
          ? context.supplicationsController.supplicationsScrollController
                  .position.isScrollingNotifier.value
              ? 1.0
              : 0.0
          : 0.0,
      child: CustomPaint(
        size: Size(context.width * .10, context.width * .10),
        painter: customPainter,
      ),
    ),
  );
}

double _getMaxProgress(BuildContext context) {
  return context
          .supplicationsController.supplicationsScrollController.hasClients
      ? context.supplicationsController.supplicationsScrollController.position
          .maxScrollExtent
      : double.infinity;
}
