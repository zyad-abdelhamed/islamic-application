import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/helper_function/get_widget_depending_on_reuest_state.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/features/duaa/presentation/controllers/cubit/duaa_cubit.dart';
import 'package:test_app/features/duaa/presentation/view/component/duaa_display.dart';

class DuaaListPagination extends StatefulWidget {
  const DuaaListPagination({super.key});

  @override
  State<DuaaListPagination> createState() => _DuaaListPaginationState();
}

class _DuaaListPaginationState extends State<DuaaListPagination> {
  final ScrollController _scrollController = ScrollController();
  int _page = 0;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<DuaaCubit>();
    cubit.getDuaa(page: _page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.75) {
        if (cubit.state.duaaRequestState != RequestStateEnum.loading) {
          _page++;
          cubit.getDuaa(page: _page);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DuaaCubit, DuaaState>(
      builder: (context, state) {
        return ListView.builder(
          controller: _scrollController,
          itemCount: state.duaas.length,
          itemBuilder: (context, index) {
            return getWidgetDependingOnReuestState(
              requestStateEnum: state.duaaRequestState,
              widgetIncaseSuccess: DuaaDisplay(
                duaaTitle: state.duaas[index].title,
                duaaBody: state.duaas[index].content,
              ),
              erorrMessage: state.duaaErrorMessage,
            );
          },
        );
      },
    );
  }
}
