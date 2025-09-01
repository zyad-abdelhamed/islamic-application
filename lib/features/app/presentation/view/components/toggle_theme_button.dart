import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/adaptive_switch.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/theme_provider.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AdaptiveSwitch(
          name: AppStrings.translate("darkMode"),
          value: context.watch<ThemeCubit>().state,
          onChanged: (_) {
            ThemeCubit.controller(context).toggleTheme();
          },
        ),
      ),
    );
  }
}
