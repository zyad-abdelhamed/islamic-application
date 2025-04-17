import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/circle_painter.dart';
import 'package:test_app/features/app/presentation/view/components/featured_records_widget.dart';
import 'package:test_app/core/constants/view_constants.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';
import 'package:test_app/core/helper_function/get_widget_depending_on_reuest_state.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class FeatuerdRecordsBlocBuilder extends StatelessWidget {
  const FeatuerdRecordsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedRecordsCubit, FeaturedRecordsState>(
      builder: (context, state) {
        print('Featured Records rebuild$state');
        return getWidgetDependingOnReuestState(
            requestStateEnum: state.featuredRecordsRequestState,
            widgetIncaseSuccess: state.featuredRecords.isNotEmpty
                ? Stack(
                    clipBehavior: Clip.none,
                    children: [
                      //circle slider
                      Positioned(
                          right: _getCircleSliderPositioned(context),
                          child: Row(spacing: 5, children: [
                            AnimatedOpacity(
                              duration: ViewConstants.mediumDuration,
                              opacity: _iscircleSliderComponentVisible(context),
                              child: CustomPaint(
                                  size: Size(
                                      context.width * .10, context.width * .10),
                                  painter: CirclePainter(
                                      lineSize: 5.0,
                                      progress: _getMaxProgress(context),
                                      context: context,
                                      lineColor: AppColors.inActiveThirdColor,
                                      maxProgress: _getMaxProgress(context))),
                            ),
                            ...List.generate(
                                3,
                                (index) => AnimatedOpacity(
                                      duration: ViewConstants
                                          .circleAvatarsDurations[index],
                                      opacity: _iscircleSliderComponentVisible(
                                          context),
                                      child: CircleAvatar(
                                        radius: 2,
                                        backgroundColor: Colors.black,
                                      ),
                                    )),
                          ])),

                      Positioned(
                          right: _getCircleSliderPositioned(context),
                          child: AnimatedOpacity(
                            duration: ViewConstants.mediumDuration,
                            opacity: _iscircleSliderComponentVisible(context),
                            child: CustomPaint(
                                size: Size(
                                    context.width * .10, context.width * .10),
                                painter: CirclePainter(
                                    lineSize: 5.0,
                                    progress: state.progress,
                                    context: context,
                                    lineColor: AppColors.thirdColor,
                                    maxProgress: _getMaxProgress(context))),
                          )),

//show data widget
                      ListView.separated(
                        controller: context.featuerdRecordsController
                            .featuredRecordsScrollController,
                        separatorBuilder: (context, index) {
                          return Row(
                            children: [
                              Expanded(child: SizedBox()),
                              Expanded(
                                flex: 3,
                                child: const Divider(
                                    thickness: .5, endIndent: 10.0),
                              ),
                            ],
                          );
                        },
                        itemCount: state.featuredRecords.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Expanded(
                                child: IconButton(
                                    onPressed: () => showDeleteAlertDialog(
                                          context,
                                          deleteFunction: () {
                                            Navigator.pop(context);

                                            context.featuerdRecordsController
                                                .deleteFeatuerdRecord(
                                                    id: index,
                                                    context: context);
                                          },
                                        ),
                                    icon: Icon(Icons.delete)),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  state.featuredRecords[index].toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyles.bold20(context),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                    ViewConstants.emptyList,
                    style: TextStyles.regular16_120(context,
                        color: AppColors.secondryColor),
                  )),
            erorrMessage: state.featuredRecordsErrorMessage);
      },
    );
  }
}

//circle slider helper functions
double _iscircleSliderComponentVisible(BuildContext context) {
  return context
          .featuerdRecordsController.featuredRecordsScrollController.hasClients
      ? context.featuerdRecordsController.featuredRecordsScrollController
              .position.isScrollingNotifier.value
          ? 1.0
          : 0.0
      : 0.0;
}

double _getMaxProgress(BuildContext context) {
  return context.featuerdRecordsController.featuredRecordsScrollController.hasClients
      ? context.featuerdRecordsController.featuredRecordsScrollController
          .position.maxScrollExtent
      : double.infinity;
}

//helper functions
double _getCircleSliderPositioned(BuildContext context) {
  return -((context.width * .10) //circle slider size
          +
          (3 //3 circle avatar
              *
              (2 *
                  2)) //one of circle avatar have radius = 2 to get it's width multiply it in 2
          +
          (3 * 5) //5 for row spacing
      );
}
