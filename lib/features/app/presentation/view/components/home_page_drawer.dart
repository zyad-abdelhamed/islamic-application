import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/adaptive_switch.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/core/widgets/app_divider.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/duaa/presentation/controllers/cubit/duaa_cubit.dart';
import 'package:test_app/features/duaa/presentation/view/component/duaa_display.dart';

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

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(
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
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state.duaaRequestState == RequestStateEnum.failed &&
                      state.duaas.isEmpty) {
                    return Center(child: Text(state.duaaErrorMessage));
                  }
                  return ListView.builder(
                    itemCount: state.duaas.length,
                    itemBuilder: (context, index) {
                      return DuaaDisplay(
                        duaaTitle: state.duaas[index].title,
                        duaaBody: state.duaas[index].content,
                      );
                    },
                  );
                },
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
