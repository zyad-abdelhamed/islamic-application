import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/text_styles.dart';
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

            const AppDivider(),

            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, RoutesConstants.settingsPage);
              },
              child: Row(
                spacing: 8,
                children: [
                  const Icon(Icons.settings),
                  Text(
                    AppStrings.translate("settings"),
                    style: TextStyles.bold20(context).copyWith(fontSize: 23),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
