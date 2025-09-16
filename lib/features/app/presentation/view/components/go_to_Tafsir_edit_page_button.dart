import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/controller/cubit/tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/view/pages/edit_tafsir.dart';

class GoToTafsirEditPageButton extends StatelessWidget {
  const GoToTafsirEditPageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => _onTap(context),
      icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
      label: Text(
        'تحرير',
        style: TextStyles.semiBold18(
          context,
          Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    final TafsirEditCubit tafsirCubit = context.read<TafsirEditCubit>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTafsir(cubit: tafsirCubit),
      ),
    );
  }
}
