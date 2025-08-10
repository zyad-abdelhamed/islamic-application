import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/adaptive_switch.dart';
import 'package:test_app/core/helper_function/get_widget_depending_on_reuest_state.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/core/widgets/app_divider.dart';
import 'package:test_app/features/app/presentation/view/components/rosary_ring%20widget.dart';
import 'package:test_app/features/app/presentation/view/components/home_drawer_text_button.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/duaa/presentation/controllers/cubit/duaa_cubit.dart';
import 'package:test_app/features/duaa/presentation/view/component/duaa_display.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List textButtonsAlertDialogWidgets =
        [
      Text(
        AppStrings.translate("khetmAlquran"),
        textAlign: TextAlign.center,
        style: TextStyles.bold20(context).copyWith(
          fontFamily: 'DataFontFamily',
          color: ThemeCubit.controller(context).state
              ? Colors.grey
              : AppColors.black,
        ),
      ),
      DrawRosaryRingWidget(),
      DrawRosaryRingWidget(),
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
                text: AppStrings.translate("homeDrawerTextButtons")[index],
                alertDialogContent: textButtonsAlertDialogWidgets[index],
              );
            }),

            appDivider(),

            // Duaa Section
            BlocProvider(
              create: (context) => DuaaCubit(sl())..getDuaa(),
              child: BlocBuilder<DuaaCubit, DuaaState>(
                builder: (context, state) {
                  return Expanded(
                      child: ListView.builder(
                    itemCount: state.duaas.length,
                    itemBuilder: (context, index) {
                      return getWidgetDependingOnReuestState(
                          requestStateEnum: state.duaaRequestState,
                          widgetIncaseSuccess: DuaaDisplay(
                              duaaTitle: state.duaas[index].title,
                              duaaBody: state.duaas[index].content),
                          erorrMessage: state.duaaErrorMessage);
                    },
                  ));
                },
              ),
            ),

            appDivider(),

            // Theme Toggle
            Align(
              alignment: Alignment.centerRight,
              child: AdaptiveSwitch(
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
