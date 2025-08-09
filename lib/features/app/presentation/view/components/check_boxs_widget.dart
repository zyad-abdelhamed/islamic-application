import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/presentation/controller/cubit/rtabel_cubit.dart';
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
            widgetIncaseSuccess: state.checkBoxsValues.isEmpty
                ? const Center(child: CircularProgressIndicator()) // Prevent empty list error
                : SingleChildScrollView(
                    child: Wrap(
                      children: List.generate(
                        30 * 16, // Total checkboxes (30 * 16);
                        (index) {
                          return Container(
                            width: constraints.maxWidth / 16, // To make the checkbox fit
                            height: 50, // Height of each checkbox container
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.grey1),
                            ),
                            child: Transform.scale(// to increase size of check mark
                              scale: 2,
                              child: Checkbox(
                                value: state.checkBoxsValues[index],
                                activeColor: Colors.transparent,
                                checkColor: AppColors.successColor,
                                side: const BorderSide(width: 0.0),
                                onChanged: (value) {
                                  RtabelCubit.controller(context)
                                      .changeCheckBoxValue(
                                          index: index, newValue: value!);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
            erorrMessage: state.errorMessage,
          );
        },
      );
    });
  }
}
