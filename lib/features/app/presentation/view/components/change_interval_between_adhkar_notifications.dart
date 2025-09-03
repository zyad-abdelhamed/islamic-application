import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/features/app/presentation/controller/controllers/repeat_interval_controller.dart';
import 'package:test_app/features/app/presentation/controller/controllers/settings_page_controller.dart';

class ChangeIntervalBetweenAdhkarNotificationsWidget extends StatelessWidget {
  const ChangeIntervalBetweenAdhkarNotificationsWidget({
    super.key,
    required this.stateNotifier,
  });

  final ValueNotifier<SettingsPageState> stateNotifier;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RepeatIntervalProvider>(
      //فـ Provider بيتولى إدارة دورة حياة الـ ChangeNotifier ويقوم بعمل dispose تلقائي عند إزالة الـ Widget من الـ tree.
      lazy: true,
      create: (_) => RepeatIntervalProvider(),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<RepeatIntervalProvider>(
            child: TextButton.icon(
              onPressed: null,
              label: Text(
                "معدل ظهور الأذكار",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              icon: const Icon(Icons.access_time, color: Colors.blue),
            ),
            builder: (BuildContext context, RepeatIntervalProvider controller,
                Widget? child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      child!,
                      Text(
                        controller.formattedTime,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: controller.sliderColor,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: controller.currentMinutes.toDouble(),
                    min: 10,
                    max: 180, // 3 hours
                    divisions: 17,
                    label: controller.formattedTime,
                    activeColor: controller.sliderColor,
                    inactiveColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey.shade800
                            : Colors.grey.shade300,
                    onChanged: (value) =>
                        controller.updateMinutes(value.toInt()),
                  ),
                  if (controller.isChanged) ...[
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () => controller.saveInterval(stateNotifier),
                      icon: const Icon(Icons.save),
                      label: const Text("تحديث"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ]
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
