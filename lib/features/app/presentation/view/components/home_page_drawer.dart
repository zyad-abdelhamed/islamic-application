import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/adaptive_switch.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/view/components/draw_circle_line_bloc_builder.dart';
import 'package:test_app/features/app/presentation/view/components/duaa_list_pagination.dart';
import 'package:test_app/features/app/presentation/view/components/rosary_ring_widget.dart';
import 'package:test_app/features/app/presentation/view/components/home_drawer_text_button.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/duaa/presentation/controllers/cubit/duaa_cubit.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<StatelessWidget> textButtonsAlertDialogWidgets =
        <StatelessWidget>[
      Text(
        AppStrings.khetmAlquran,
        textAlign: TextAlign.center,
        style: TextStyles.bold20(context).copyWith(
          fontFamily: 'DataFontFamily',
          color: ThemeCubit.controller(context).state
              ? Colors.grey
              : AppColors.black,
        ),
      ),
      RosaryRingWidget(),
      DrawCircleLineBlocBuilder(
        customPaintSize: 200,
        maxProgress: 100.0,
        functionality:
            DrawCircleLineBlocBuilderFunctionality.rosariesAfterPrayer,
      ),
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Text Button List
            ...List.generate(textButtonsAlertDialogWidgets.length, (index) {
              return HomeDrawerTextButton(
                index: index,
                text: AppStrings.homeDrawerTextButtons[index],
                alertDialogContent: textButtonsAlertDialogWidgets[index],
              );
            }),

            const Divider(color: Colors.grey),

            // Duaa Section
            Expanded(
              child: BlocProvider(
                create: (context) => DuaaCubit(sl()),
                child: const DuaaListPagination(),
              ),
            ),

            const Divider(color: Colors.grey),

            // Theme Toggle
            Align(
              alignment: Alignment.centerRight,
              child: AdaptiveSwitch(
                name: AppStrings.darkMode,
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
