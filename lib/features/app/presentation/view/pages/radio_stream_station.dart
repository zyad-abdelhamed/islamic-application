import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/extentions/media_query_extention.dart';
import 'package:test_app/core/widgets/custom_scaffold.dart';
import 'package:test_app/features/app/presentation/controller/change_notifier/radio_station_stream_controller.dart';

class RadioStationPage extends StatelessWidget {
  const RadioStationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text("إذاعة القرآن الكريم"),
        leading: const GetAdaptiveBackButtonWidget(),
      ),
      body: ChangeNotifierProvider<RadioStationStreamController>(
        create: (_) => RadioStationStreamController(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Consumer<RadioStationStreamController>(
            child: Icon(Icons.radio,
                size: context.width * 0.3, color: AppColors.primaryColor),
            builder: (context, provider, Widget? child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  child!,
                  const SizedBox(height: 16),
                  Text(
                    provider.station.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    provider.statusText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: provider.statusTextColor,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.teal,
                      foregroundColor: Colors.white,
                    ),
                    icon: Icon(provider.buttonIcon),
                    label: Text(provider.buttonLabel),
                    onPressed: provider.isLoading ? null : provider.togglePlay,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
