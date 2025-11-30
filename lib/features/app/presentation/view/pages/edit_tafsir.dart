import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/widgets/custom_scaffold.dart';
import 'package:test_app/features/app/presentation/controller/cubit/tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/tafsir_content.dart';

class EditTafsir extends StatelessWidget {
  const EditTafsir({super.key, required this.cubit});

  final TafsirEditCubit cubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: CustomScaffold(
        appBar: AppBar(
          title: Text("تحرير التفسير"),
          leading:
              const GetAdaptiveBackButtonWidget(backBehavior: BackBehavior.pop),
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: TafsirContent(),
        ),
      ),
    );
  }
}
