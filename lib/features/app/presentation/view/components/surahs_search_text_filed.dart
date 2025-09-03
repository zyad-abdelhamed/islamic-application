import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surahs_info_cubit.dart';

class SurahsSearchTextFiled extends StatelessWidget {
  const SurahsSearchTextFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: AppStrings.translate("surahsSearchHintText"),
      ),
      onChanged: (String value) =>
          context.read<GetSurahsInfoCubit>().search(value),
    );
  }
}
