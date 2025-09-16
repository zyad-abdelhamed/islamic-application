import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/controller/cubit/tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/tafsir_state.dart';

class TafsirContent extends StatelessWidget {
  const TafsirContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('تفسيراتى', style: TextStyles.semiBold16_120(context)),
        const SizedBox(height: 8),
        BlocSelector<TafsirEditCubit, TafsirEditState, List<String>>(
          selector: (state) => state.selected,
          builder: (context, selected) =>
              SelectedTafsirList(selected: selected),
        ),
        const SizedBox(height: 20),
        Text('التفاسير', style: TextStyles.semiBold16_120(context)),
        const SizedBox(height: 8),
        BlocSelector<TafsirEditCubit, TafsirEditState, List<String>>(
          selector: (state) => state.available,
          builder: (context, available) =>
              AvailableTafsirList(available: available),
        ),
        const SizedBox(height: 20),
        const InfoRow(),
      ],
    );
  }
}

class SelectedTafsirList extends StatelessWidget {
  final List<String> selected;
  const SelectedTafsirList({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    final TafsirEditCubit cubit = context.read<TafsirEditCubit>();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.lightModePrimaryColor,
      ),
      child: ReorderableListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: selected.length,
        onReorder: cubit.reorder,
        buildDefaultDragHandles: false,
        proxyDecorator: (child, index, animation) {
          return Material(
            color: Colors.transparent,
            child: child,
          );
        },
        itemBuilder: (context, index) {
          final tafsir = selected[index];
          return ListTile(
            key: ValueKey(tafsir),
            trailing: ReorderableDragStartListener(
              index: index,
              child: Icon(Icons.drag_handle_rounded, color: Colors.white),
            ),
            leading: IconButton(
              onPressed: () => cubit.removeTafsir(tafsir),
              icon: const Icon(Icons.remove_circle),
              color: Colors.grey,
            ),
            title: Text(
              tafsir,
              style: TextStyles.semiBold18(context, AppColors.white),
            ),
          );
        },
      ),
    );
  }
}

class AvailableTafsirList extends StatelessWidget {
  final List<String> available;
  const AvailableTafsirList({super.key, required this.available});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TafsirEditCubit>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.lightModePrimaryColor,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: available.length,
        itemBuilder: (context, index) {
          final tafsir = available[index];
          return ListTile(
            leading: IconButton(
              onPressed: () => cubit.addTafsir(tafsir),
              icon: const Icon(Icons.add_circle),
              color: AppColors.successColor,
            ),
            title: Text(
              tafsir,
              style: TextStyles.semiBold18(context, AppColors.white),
            ),
          );
        },
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.info_outline,
          color: AppColors.lightModePrimaryColor,
        ),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            'يمكن تغيير ترتيب التفاسير عن طريق ضغطة مطولة عليها ثم تحريكها',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
