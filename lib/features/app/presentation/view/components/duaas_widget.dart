import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/features/app/presentation/controller/cubit/duaa_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/duaa_display.dart';
import 'package:test_app/core/utils/enums.dart';

class DuaasWidget extends StatelessWidget {
  const DuaasWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          style:  TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: 'ابحث عن الدعاء',
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          onChanged: (value) {
            context.read<DuaaCubit>().searchDuaa(value);
          },
        ),
      ),
      Expanded(
        child: BlocBuilder<DuaaCubit, DuaaState>(
          builder: (context, state) {
            if (state.duaaRequestState == RequestStateEnum.loading) {
              return const GetAdaptiveLoadingWidget();
            }
            if (state.duaaRequestState == RequestStateEnum.failed &&
                state.duaas.isEmpty) {
              return Center(child: Text(state.duaaErrorMessage));
            }
            return ListView.builder(
              key: UniqueKey(),
              itemCount: state.duaas.length,
              itemBuilder: (context, index) {
                return DuaaDisplay(
                  key: UniqueKey(),
                  duaaTitle: state.duaas[index].title,
                  duaaBody: state.duaas[index].content,
                );
              },
            );
          },
        ),
      )
    ]);
  }
}
