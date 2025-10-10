import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/widgets/app_divider.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/tafsir_state.dart';
import 'package:test_app/features/app/presentation/view/components/expandable_tafsir_card.dart';
import 'package:test_app/features/app/presentation/view/components/go_to_Tafsir_edit_page_button.dart';

class TafsirBottomSheet extends StatelessWidget {
  const TafsirBottomSheet({
    super.key,
    required this.ayahText,
    required this.allTafsir,
    required this.index,
  });

  final String ayahText;
  final Map<String, TafsirAyahEntity> Function(List<String> tafsirEditions)
      allTafsir;
  final int index;

  @override
  Widget build(BuildContext context) {
    final Color dataColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey
        : Colors.black;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          child: BlocProvider<TafsirEditCubit>(
            create: (_) => sl<TafsirEditCubit>(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GoToTafsirEditPageButton(),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    "﴿ $ayahText ﴾",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Amiri',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const AppDivider(),
                BlocBuilder<TafsirEditCubit, TafsirEditState>(
                  builder: (context, state) {
                    return ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.selected.length,
                      itemBuilder: (context, index) {
                        final String tafsirEdition = state.selected[index];

                        return ExpandableTafsirCard(
                          title: tafsirEdition,
                          tafsirText:
                              allTafsir(state.tafsirEditions)[tafsirEdition]!
                                  .text,
                          dataColor: dataColor,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
