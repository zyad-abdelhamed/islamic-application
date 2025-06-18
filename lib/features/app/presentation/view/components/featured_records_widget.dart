import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/helper_function/get_widget_depending_on_reuest_state.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

class FeatuerdRecordsWidget extends StatelessWidget {
  const FeatuerdRecordsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => context.featuerdRecordsController.addFeatuerdRecord(item: context.elecRosaryController.counter, context: context),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: AppColors.inActivePrimaryColor,
                borderRadius: BorderRadius.circular(23)),
            child: const Icon(
              Icons.save,
              color: AppColors.primaryColor,
              size: 40,
            ),
          ),
        ),
        Container(
          width: 180,
          height: 150 * 1.5,
          margin: const EdgeInsets.only(bottom: 35.0),
          decoration: BoxDecoration(
              color: context.watch<ThemeCubit>().state
                  ? AppColors.grey2
                  : Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(13), topRight: Radius.circular(13)),
              boxShadow: _boxShadow(context)),
          child: Column(
            children: [
              Divider(
                thickness: 5,
                color: Colors.grey,
                indent: 50,
                endIndent: 50,
              ),
              Center(
                child: Text(
                  AppStrings.featuerdRecords,
                  style: TextStyles.semiBold16_120(context),
                ),
              ),
              Visibility(
                visible: context.featuerdRecordsController.state.featuredRecords
                        .length >
                    1,
                child: GestureDetector(
                    onTap: () => showDeleteAlertDialog(
                          context,
                          deleteFunction: () {
                            Navigator.pop(context);
                            context.featuerdRecordsController
                                .deleteAllFeatuerdRecords(context);
                          },
                        ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(AppStrings.deleteAll,
                          style: TextStyles.regular14_150(context)
                              .copyWith(color: AppColors.thirdColor)),
                    )),
              ),
              Expanded(child:
                  BlocBuilder<FeaturedRecordsCubit, FeaturedRecordsState>(
                builder: (context, state) {
                  return getWidgetDependingOnReuestState(
                      requestStateEnum: state.featuredRecordsRequestState,
                      widgetIncaseSuccess: state.featuredRecords.isNotEmpty
                          ? ListView.separated(
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
                                          onPressed: () =>
                                              showDeleteAlertDialog(
                                                context,
                                                deleteFunction: () {
                                                  Navigator.pop(context);

                                                  context
                                                      .featuerdRecordsController
                                                      .deleteFeatuerdRecord(
                                                          id: index,
                                                          context: context);
                                                },
                                              ),
                                          icon: const Icon(CupertinoIcons.delete)),
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
                            )
                          : Center(
                              child: Text(
                              AppStrings.emptyList,
                              style: TextStyles.regular14_150(
                                context,
                              ),
                            )),
                      erorrMessage: state.featuredRecordsErrorMessage);
                },
              )),
            ],
          ),
        ),
      ],
    );
  }

  List<BoxShadow> _boxShadow(BuildContext context) {
    const double spreadRadius = 3;

    return <BoxShadow>[
      BoxShadow(
          offset: const Offset(3, 3),
          spreadRadius: spreadRadius,
          color: Colors.grey.withValues(alpha: 0.1))
    ];
  }
}

//alert dialog
void showDeleteAlertDialog(BuildContext context,
    {required VoidCallback deleteFunction}) {
  showAdaptiveDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        actionsAlignment: MainAxisAlignment.start,
        title: Text(AppStrings.areYouSure),
        actions: [
          OutlinedButton(
              onPressed: deleteFunction,
              child: Text(
                AppStrings.yes,
                style: TextStyles.regular16_120(context,
                    color: AppColors.thirdColor),
              )),
          OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppStrings.no,
                  style: TextStyles.regular16_120(context,
                      color: AppColors.primaryColor)))
        ],
      );
    },
  );
}
