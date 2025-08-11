import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/helper_function/get_widget_depending_on_reuest_state.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/delete_alert_dialog.dart';

class FeaturedRecordsBlocBuilder extends StatelessWidget {
  const FeaturedRecordsBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedRecordsCubit, FeaturedRecordsState>(
      builder: (context, state) {
        return getWidgetDependingOnReuestState(
            requestStateEnum: state.featuredRecordsRequestState,
            widgetIncaseSuccess: state.featuredRecords.isNotEmpty
                ? ListView.separated(
                    controller: FeaturedRecordsCubit.controller(context)
                        .featuredRecordsScrollController,
                    separatorBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(child: SizedBox()),
                          Expanded(
                            flex: 3,
                            child:
                                const Divider(thickness: .5, endIndent: 10.0),
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
                                        FeaturedRecordsCubit.controller(context)
                                            .deleteFeatuerdRecord(
                                                id: index, context: context);
                                        Navigator.pop(context);
                                      },
                                    ),
                                icon: const Icon(CupertinoIcons.delete)),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              state.featuredRecords[index].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyles.bold20(context).copyWith(fontFamily: 'dataFontFamily'),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                : Center(
                    child: Text(
                    AppStrings.translate("emptyList"),
                    style: TextStyles.regular14_150(
                      context,
                    ),
                  )),
            erorrMessage: state.featuredRecordsErrorMessage);
      },
    );
  }
}
