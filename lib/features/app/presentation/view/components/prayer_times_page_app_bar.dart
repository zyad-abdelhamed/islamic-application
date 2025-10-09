import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/controller/controllers/prayer_times_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayers_sound_settings_cubit.dart';

class PrayerTimesPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PrayerTimesPageAppBar(
      {super.key,
      required this.prayerTimesPageController,
      required this.prayerSoundSettingsCubit});

  final PrayerTimesPageController prayerTimesPageController;
  final PrayerSoundSettingsCubit prayerSoundSettingsCubit;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("مواقيت الصلاه"),
      leading: ListenableBuilder(
        listenable: Listenable.merge([
          prayerTimesPageController.prayerSoundSettingsEntityNotifier,
          prayerTimesPageController.originalPrayerSoundSettings
        ]),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: prayerTimesPageController.cancelPrayerSoundChanges,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 3,
              children: [
                const SizedBox(width: 8),
                Icon(Icons.close, color: AppColors.errorColor, size: 16),
                Text(
                  "الغاء",
                  style: TextStyles.regular16_120(context,
                      color: AppColors.errorColor),
                ),
              ],
            ),
          ),
        ),
        builder: (_, Widget? child) {
          if (prayerTimesPageController.hasPrayerSoundChanges) {
            return child!;
          } else {
            return const GetAdaptiveBackButtonWidget();
          }
        },
      ),
      actions: [
        ListenableBuilder(
            listenable: Listenable.merge([
              prayerTimesPageController.prayerSoundSettingsEntityNotifier,
              prayerTimesPageController.originalPrayerSoundSettings
            ]),
            child: GestureDetector(
              onTap: () => prayerSoundSettingsCubit.saveSettings(
                  prayerTimesPageController
                      .prayerSoundSettingsEntityNotifier.value!),
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(spacing: 3, children: [
                  const Icon(Icons.check, color: Colors.white),
                  Text(
                    "تأكيد",
                    style: TextStyles.semiBold16(
                        context: context, color: Colors.white),
                  ),
                ]),
              ),
            ),
            builder: (_, Widget? child) =>
                prayerTimesPageController.hasPrayerSoundChanges
                    ? child!
                    : const SizedBox.shrink())
      ],
    );
  }
}
