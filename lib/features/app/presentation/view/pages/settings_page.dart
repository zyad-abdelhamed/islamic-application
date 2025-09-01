import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/presentation/controller/controllers/notifications_settings_controller.dart';
import 'package:test_app/features/app/presentation/controller/controllers/settings_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/reset_app_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/change_interval_between_adhkar_notifications.dart';
import 'package:test_app/features/app/presentation/view/components/notifications_settings_widget.dart';
import 'package:test_app/features/app/presentation/view/components/reset_app_button.dart';
import 'package:test_app/features/app/presentation/view/components/reset_app_screen.dart';
import 'package:test_app/features/app/presentation/view/components/toggle_theme_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final NotificationsSettingsController notificationsController;
  late final SettingsController settingsController;

  @override
  void initState() {
    super.initState();
    settingsController = SettingsController();
    notificationsController =
        NotificationsSettingsController(settingsController.pageState);
  }

  @override
  void dispose() {
    settingsController.dispose();
    notificationsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResetAppCubit>(
        create: (_) => sl<ResetAppCubit>(),
        child: BlocListener<ResetAppCubit, ResetAppState>(
          listener: (context, state) {
            if (state is ResetAppLoading) {
              Navigator.pop(context);

              settingsController.pageState.value =
                  SettingsPageState.deletingAllData;
            } else if (state is ResetAppError) {
              AppSnackBar(message: state.message, type: AppSnackBarType.error)
                  .show(context);
            } else if (state is ResetAppSuccess) {
              FlutterExitApp.exitApp();
            }
          },
          child: ValueListenableBuilder<SettingsPageState>(
            valueListenable: settingsController.pageState,
            builder:
                (BuildContext context, SettingsPageState value, Widget? child) {
              return value == SettingsPageState.deletingAllData
                  ? const ResetAppScreen()
                  : ModalProgressHUD(
                      inAsyncCall: value == SettingsPageState.loading,
                      progressIndicator: const GetAdaptiveLoadingWidget(),
                      opacity: .5,
                      child: child!,
                    );
            },
            child: Scaffold(
              backgroundColor: context.watch<ThemeCubit>().state
                  ? AppColors.darkModeSettingsPageBackgroundColor
                  : AppColors.lightModeSettingsPageBackgroundColor,
              appBar: AppBar(
                title: Text(AppStrings.translate("settings")),
                leading: const GetAdaptiveBackButtonWidget(),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 20,
                  children: [
                    ValueListenableBuilder<bool>(
                        valueListenable:
                            notificationsController.isAdhkarEnabled,
                        child: ChangeIntervalBetweenAdhkarNotificationsWidget(
                          stateNotifier: settingsController.pageState,
                        ),
                        builder:
                            (BuildContext context, bool value, Widget? child) {
                          return Visibility(
                            visible: value,
                            child: child!,
                          );
                        }),
                    NotificationsSettingsWidget(
                        notificationsController: notificationsController),
                    const ToggleThemeButton(),
                    const Spacer(),
                    ResetAppButton(settingsController: settingsController),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
