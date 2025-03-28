import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app/presentation/controller/cubit/rtabel_cubit.dart';
import 'package:test_app/core/extentions/controllers_extention.dart';
import 'package:test_app/core/theme/app_colors.dart';

class CheckBoxsWidget extends StatelessWidget {
  const CheckBoxsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return BlocBuilder<RtabelCubit, RtabelState>(
        builder: (context, state) {
          return Wrap(
              children: List.generate(
                  16 * 30,
                  (index) => Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey1)),
                        width: constraints.maxWidth / 16,
                        height: 50, //50 for hight (blue container)
                        child: Center(
                          child: Checkbox(
                            value: state.checkBoxsValues?[index] ?? false,
                            onChanged: (value) {
                              context.ramadanTableController
                                  .changeCheckBoxValue(
                                      index: index, newValue: value!);
                            },
                          ),
                        ),
                      )));
        },
      );
    });
  }
}
