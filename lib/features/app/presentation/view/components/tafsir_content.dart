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
          builder: (_, selected) => TafsirListView(
            items: selected,
            mode: TafsirListMode.reorderable,
          ),
        ),
        const SizedBox(height: 20),
        Text('التفاسير', style: TextStyles.semiBold16_120(context)),
        const SizedBox(height: 8),
        BlocSelector<TafsirEditCubit, TafsirEditState, List<String>>(
          selector: (state) => state.available,
          builder: (_, available) => TafsirListView(
            items: available,
            mode: TafsirListMode.normal,
          ),
        ),
        const SizedBox(height: 20),
        const InfoRow(),
      ],
    );
  }
}

// =======================================================
// Unified List View
// =======================================================

enum TafsirListMode { normal, reorderable }

class TafsirListView extends StatelessWidget {
  final List<String> items;
  final TafsirListMode mode;

  const TafsirListView({
    super.key,
    required this.items,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    final cubit = context.read<TafsirEditCubit>();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryColor,
      ),
      child: mode == TafsirListMode.reorderable
          ? _buildReorderable(cubit)
          : _buildNormal(cubit),
    );
  }

  Widget _buildReorderable(TafsirEditCubit cubit) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      onReorder: cubit.reorder,
      buildDefaultDragHandles: false,
      proxyDecorator: (child, _, __) =>
          Material(color: Colors.transparent, child: child),
      itemBuilder: (_, index) {
        final tafsir = items[index];
        return TafsirTile(
          key: ValueKey(tafsir),
          title: tafsir,
          leading: IconButton(
            icon: const Icon(Icons.remove_circle, color: Colors.grey),
            onPressed: () => cubit.removeTafsir(tafsir),
          ),
          trailing: ReorderableDragStartListener(
            index: index,
            child: const Icon(
              Icons.drag_handle_rounded,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  Widget _buildNormal(TafsirEditCubit cubit) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (_, index) {
        final tafsir = items[index];
        return TafsirTile(
          title: tafsir,
          leading: IconButton(
            icon: const Icon(
              Icons.add_circle,
              color: AppColors.successColor,
            ),
            onPressed: () => cubit.addTafsir(tafsir),
          ),
        );
      },
    );
  }
}

// =======================================================
// Shared Tile
// =======================================================

class TafsirTile extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget? trailing;

  const TafsirTile({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      trailing: trailing,
      title: Text(
        title,
        style: TextStyles.semiBold18(context, Colors.white),
      ),
    );
  }
}

// =======================================================
// Info Row
// =======================================================

class InfoRow extends StatelessWidget {
  const InfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, color: AppColors.primaryColor),
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
