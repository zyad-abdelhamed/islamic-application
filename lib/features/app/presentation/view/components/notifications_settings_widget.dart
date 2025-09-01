import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/adaptive_switch.dart';
import 'package:test_app/core/widgets/app_divider.dart';
import 'package:test_app/features/app/presentation/controller/controllers/notifications_settings_controller.dart';

class NotificationsSettingsWidget extends StatelessWidget {
  const NotificationsSettingsWidget({
    super.key,
    required this.notificationsController,
  });

  final NotificationsSettingsController notificationsController;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "إعدادات الإشعارات",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const AppDivider(),
            ValueListenableBuilder<bool>(
              valueListenable: notificationsController.isPrayerEnabled,
              builder: (_, bool value, __) {
                return AdaptiveSwitch(
                  name: "إشعارات الصلوات",
                  value: value,
                  onChanged: notificationsController.togglePrayer,
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: notificationsController.isAdhkarEnabled,
              builder: (_, bool value, __) {
                return AdaptiveSwitch(
                  name: "إشعارات الأذكار اليومية",
                  value: value,
                  onChanged: notificationsController.toggleAdhkar,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
