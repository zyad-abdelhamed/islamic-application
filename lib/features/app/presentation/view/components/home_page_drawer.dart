import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/adaptive_switch.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/core/widgets/app_divider.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/presentation/controller/cubit/duaa_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/duaas_widget.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Duaa Section
            Expanded(
              child: BlocProvider<DuaaCubit>(
                create: (_) => sl<DuaaCubit>(),
                child: DuaasWidget(),
              ),
            ),

            appDivider(),

            // Theme Toggle
            Align(
              alignment: Alignment.centerRight,
              child: AdaptiveSwitch(
                mainAxisAlignment: MainAxisAlignment.start,
                name: AppStrings.translate("darkMode"),
                onChanged: ThemeCubit.controller(context).toggleTheme,
                value: context.watch<ThemeCubit>().state,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
