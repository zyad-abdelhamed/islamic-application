import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/domain/entities/prayer_sound_settings_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/prayer_times_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayers_sound_settings_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayers_sound_settings_state.dart';
import 'package:test_app/features/app/presentation/view/components/prayers_sounds_widget.dart';

class PrayersSoundsSettingsBlocConsumer extends StatelessWidget {
  final PrayerTimesPageController controller;

  const PrayersSoundsSettingsBlocConsumer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrayerSoundSettingsCubit, PrayerSoundSettingsState>(
      listener: (context, state) {
        if (state is PrayerSoundSettingsLoaded) {
          controller.initPrayerSettings(state.settings);
        } else if (state is PrayerSoundSettingsSaving) {
          controller.loadingNotifier.value = true;
        } else if (state is PrayerSoundSettingsSaved) {
          controller.markAsSaved();
          controller.loadingNotifier.value = false;
          AppSnackBar(
              message: AppStrings.translate("settingsSaved"), type: AppSnackBarType.success).show(context);
        } else if (state is PrayerSoundSettingsError) {
          controller.loadingNotifier.value = false;
          AppSnackBar(message: state.message, type: AppSnackBarType.error).show(context);
        }
      },
      builder: (context, state) {
        if (controller.prayerSoundSettingsEntityNotifier.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return ValueListenableBuilder<PrayerSoundSettingsEntity?>(
          valueListenable: controller.prayerSoundSettingsEntityNotifier,
          builder: (context, settings, _) {
            if (settings == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return PrayersSoundSettingsWidget(
              controller: controller,
              settings: settings,
            );
          },
        );
      },
    );
  }
}
