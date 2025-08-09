import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<DuaaCubit>();

    // تحميل الصفحة الأولى
    cubit.getDuaa(page: _page).then((loaded) {
      if (!loaded) _hasMore = false;
      _loadMoreIfNotFilled();
    });

    // الاستماع للـ Scroll
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.75) {
        if (cubit.state.duaaRequestState != RequestStateEnum.loading &&
            _hasMore) {
          _page++;
          cubit.getDuaa(page: _page).then((loaded) {
            if (!loaded) _hasMore = false;
            _loadMoreIfNotFilled();
          });
        }
      }
    });
  }

  void _loadMoreIfNotFilled() {
    final cubit = context.read<DuaaCubit>();
    if (_hasMore &&
        _scrollController.position.maxScrollExtent <=
            _scrollController.position.viewportDimension) {
      _page++;
      cubit.getDuaa(page: _page).then((loaded) {
        if (!loaded) _hasMore = false;
        _loadMoreIfNotFilled();
      });
    }
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
      final isLoading = state.duaaRequestState == RequestStateEnum.loading;
      final itemCount = state.duaas.length + (isLoading ? 1 : 0);

      return ListView.builder(
        controller: _scrollController,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (index >= state.duaas.length) {
            // Loader في أسفل القائمة فقط
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return DuaaDisplay(
            duaaTitle: state.duaas[index].title,
            duaaBody: state.duaas[index].content,
          );
        },
      );
    },
  );
}


}
