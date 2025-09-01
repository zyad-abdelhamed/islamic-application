import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/adaptive_switch.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/helper_function/settings_container_decoration.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/widgets/app_divider.dart';
import 'package:test_app/features/app/domain/entities/prayer_sound_settings_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/prayer_times_page_controller.dart';

class PrayersSoundSettingsWidget extends StatelessWidget {
  const PrayersSoundSettingsWidget(
      {super.key, required this.controller, required this.settings});

  final PrayerTimesPageController controller;
  final PrayerSoundSettingsEntity settings;

  @override
  Widget build(BuildContext context) {
    final List<String> names = <String>[
      AppStrings.translate("namesOfPrayers")[0],
      AppStrings.translate("namesOfPrayers")[1],
      AppStrings.translate("namesOfPrayers")[2],
      AppStrings.translate("namesOfPrayers")[3],
      AppStrings.translate("namesOfPrayers")[4]
    ];

    return Container(
        padding: const EdgeInsets.all(8),
        decoration: settengsContainerBoxDecoration(context),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "إعدادات صوت الأذان",
                style: TextStyles.bold20(context),
              ),
              ValueListenableBuilder<bool>(
                  valueListenable: controller.isSwitchsShowedNotifier,
                  child: IconButton(
                    onPressed: () => controller.toggleIsSwitchsShowed(),
                    icon: const Icon(Icons.expand_more,
                        size: 30, color: Colors.grey),
                  ),
                  builder: (context, value, child) {
                    return AnimatedRotation(
                      duration: const Duration(milliseconds: 300),
                      turns: controller.isSwitchsShowedNotifier.value
                          ? 0.5
                          : 0.0, // تدوير السهم لأعلى/أسفل
                      child: child,
                    );
                  }),
            ],
          ),
          ValueListenableBuilder<bool>(
              valueListenable: controller.isSwitchsShowedNotifier,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppDivider(),
                  AdaptiveSwitch(
                    name: names[0],
                    value: settings.fajr,
                    onChanged: (_) => controller.updatePrayerSoundSetting(
                        names[0], !settings.fajr),
                  ),
                  AdaptiveSwitch(
                    name: names[1],
                    value: settings.dhuhr,
                    onChanged: (_) => controller.updatePrayerSoundSetting(
                        names[1], !settings.dhuhr),
                  ),
                  AdaptiveSwitch(
                    name: names[2],
                    value: settings.asr,
                    onChanged: (_) => controller.updatePrayerSoundSetting(
                        names[2], !settings.asr),
                  ),
                  AdaptiveSwitch(
                    name: names[3],
                    value: settings.maghrib,
                    onChanged: (_) => controller.updatePrayerSoundSetting(
                        names[3], !settings.maghrib),
                  ),
                  AdaptiveSwitch(
                    name: names[4],
                    value: settings.isha,
                    onChanged: (_) => controller.updatePrayerSoundSetting(
                        names[4], !settings.isha),
                  )
                ],
              ),
              builder: (context, value, child) {
                return AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn,
                  child: !controller.isSwitchsShowedNotifier.value
                      ? const SizedBox.shrink()
                      : child,
                );
              })
        ]));
  }
}
