import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/helper_function/get_widget_depending_on_reuest_state.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/view/components/draw_circle_line_bloc_builder.dart';
import 'package:test_app/features/app/presentation/view/components/rosary_ring_widget.dart';
import 'package:test_app/features/app/presentation/view/components/home_drawer_text_button.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/duaa/presentation/controllers/cubit/duaa_cubit.dart';
import 'package:test_app/features/duaa/presentation/view/component/duaa_display.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<StatelessWidget> textButtonsAlertDialogWidgets =
        <StatelessWidget>[
      DrawCircleLineBlocBuilder(
          customPaintSize: 200,
          maxProgress: 100.0,
          functionality:
              DrawCircleLineBlocBuilderFunctionality.rosariesAfterPrayer),
      RosaryRingWidget(),
      Text(
        AppStrings.khetmAlquran,
        textAlign: TextAlign.center,
        style: TextStyles.semiBold20(context).copyWith(color: AppColors.white),
      )
    ];

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
              children: List<HomeDrawerTextButton>.generate(
                  textButtonsAlertDialogWidgets.length,
                  (index) => HomeDrawerTextButton(
                        index: index,
                        text: AppStrings.homeDrawerTextButtons[index],
                        alertDialogContent:
                            textButtonsAlertDialogWidgets[index],
                      ))),
          Divider(),
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
          Divider(),
          Padding(
              padding: const EdgeInsets.only(right: 10.0, bottom: 30),
              child: Row(
                  spacing: 10.0,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.darkMode,
                      style: TextStyles.bold20(context).copyWith(fontSize: 18),
                    ),
                    Switch.adaptive(
                        activeColor: AppColors.thirdColor,
                        activeTrackColor:
                            AppColors.thirdColor.withValues(alpha: .8),
                        inactiveThumbColor: AppColors.black,
                        inactiveTrackColor: AppColors.inActiveBlackColor,
                        value: context.watch<ThemeCubit>().state,
                        onChanged: (bool value) =>
                            ThemeCubit.controller(context).toggleTheme())
                  ])),
        ],
      ),
    );
  }
}
