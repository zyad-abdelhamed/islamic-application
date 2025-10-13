import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/features/app/presentation/controller/cubit/rtabel_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/rtabel_state.dart';
import 'package:test_app/features/app/presentation/view/components/erorr_widget.dart';
import 'package:test_app/features/app/presentation/view/components/r_table_check_box.dart';

class CheckBoxsWidget extends StatelessWidget {
  const CheckBoxsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return BlocBuilder<RtabelCubit, RtabelState>(
        builder: (context, state) {
          // ===== حالة التحميل =====
          if (state.requestState == RequestStateEnum.loading) {
            return const AppLoadingWidget();
          }

          // ===== حالة الخطأ =====
          if (state.requestState == RequestStateEnum.failed) {
            return ErrorWidgetIslamic(message: state.errorMessage);
          }

          // ===== حالة النجاح =====
          if (state.requestState == RequestStateEnum.success &&
              state.checkBoxsValues.isNotEmpty) {
            return SingleChildScrollView(
              child: Wrap(
                children: List.generate(
                  30 * 16, // إجمالي عدد الـ Checkboxes
                  (index) {
                    return RTableCheckBox(
                        constraints: constraints, state: state, index: index);
                  },
                ),
              ),
            );
          }

          // ===== لو مفيش داتا =====
          return const Center(child: Text("لا توجد بيانات متاحة"));
        },
      );
    });
  }
}
