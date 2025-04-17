import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/presentation/controller/cubit/rtabel_cubit.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';
import 'package:test_app/core/helper_function/get_widget_depending_on_reuest_state.dart';
import 'package:test_app/core/theme/app_colors.dart';

class CheckBoxsWidget extends StatelessWidget {
  const CheckBoxsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return BlocBuilder<RtabelCubit, RtabelState>(
        builder: (context, state) {
          return getWidgetDependingOnReuestState(
              requestStateEnum: state.requestState,
              widgetIncaseSuccess: Wrap(
                  children: List.generate(
                      16 * 30,
                      (index) => Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.grey1)),
                            width: constraints.maxWidth / 16,
                            height: 50, //50 for hight (day container)
                            child: Center(
                              child: Checkbox(
                                value: state.checkBoxsValues[index],
                                activeColor: AppColors.primaryColor,
                                onChanged: (value) {
                                  context.ramadanTableController
                                      .changeCheckBoxValue(
                                          index: index, newValue: value!);
                                },
                              ),
                            ),
                          ))),
              erorrMessage: state.errorMessage);
        },
      );
    });
  }
}
