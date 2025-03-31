import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/core/constants/view_constants.dart';
import 'package:test_app/core/helper_function/get_widget_depending_on_reuest_state.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class FeatuerdRecordsWidget extends StatelessWidget {
  const FeatuerdRecordsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * .40,
      height: (context.width * .40) * 1.5,
      margin: const EdgeInsets.only(bottom: 35.0),
      decoration: BoxDecoration(
        color: AppColors.grey2,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(13), topRight: Radius.circular(13)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 7,
                left: context.width * .10,
                right: context.width * .10,
                bottom: 10),
            child: Divider(
              thickness: 5,
              color: Colors.grey,
            ),
          ),
          Center(
            child: Text(
              'الريكوردات المميزه',
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () => _showDeleteAlertDialog(
                        context,
                        deleteFunction: () {},
                      ),
                  child: Text('  حذف الكل',
                      style: TextStyles.regular14_150(context)
                          .copyWith(color: AppColors.thirdColor))),
              Divider(
                thickness: 3,
              ),
            ],
          ),
          Expanded(
            child: BlocBuilder<FeaturedRecordsCubit, FeaturedRecordsState>(
              builder: (context, state) {
                print('Featured Records rebuild$state');
                return getWidgetDependingOnReuestState(
                    requestStateEnum: state.featuredRecordsRequestState,
                    widgetIncaseSuccess: state.featuredRecords.isNotEmpty
                        ? AnimatedList.separated(
                            removedSeparatorBuilder:
                                (context, index, animation) {
                              return SizedBox();
                            },
                            separatorBuilder: (context, index, animation) {
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
                            physics: const BouncingScrollPhysics(),
                            initialItemCount: state.featuredRecords.length,
                            itemBuilder: (context, index, animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: SizeTransition(
                                  sizeFactor: animation,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: IconButton(
                                            onPressed: () =>
                                                _showDeleteAlertDialog(
                                                  context,
                                                  deleteFunction: () {},
                                                ),
                                            icon: Icon(Icons.delete)),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          state.featuredRecords[index]
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyles.bold20(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                            ViewConstants.emptyList,
                            style: TextStyles.regular16_120(context,
                                color: AppColors.secondryColor),
                          )),
                    erorrMessage: state.featuredRecordsErrorMessage);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteAlertDialog(BuildContext context,
      {required VoidCallback deleteFunction}) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          actionsAlignment: MainAxisAlignment.start,
          title: Text('هل أنت متأكد؟'),
          actions: [
            OutlinedButton(
                onPressed: () {
                  deleteFunction;
                  Navigator.pop(context);
                },
                style: _outlinedButtonStyle,
                child: Text(
                  'نعم',
                  style: TextStyles.regular16_120(context,
                      color: AppColors.primaryColor),
                )),
            OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: _outlinedButtonStyle,
                child: Text('لا',
                    style: TextStyles.regular16_120(context,
                        color: AppColors.primaryColor)))
          ],
        );
      },
    );
  }
}

ButtonStyle _outlinedButtonStyle = ButtonStyle(
    shape: WidgetStatePropertyAll(
        ContinuousRectangleBorder(borderRadius: BorderRadius.circular(15.0))));
