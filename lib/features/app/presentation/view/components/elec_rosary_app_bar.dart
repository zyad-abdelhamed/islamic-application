import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/presentation/controller/controllers/counter_controller.dart';

class ElecRosaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ElecRosaryAppBar({
    super.key,
    required this.counterController,
  });

  final CounterController counterController;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const GetAdaptiveBackButtonWidget(),
      title: Text(AppStrings.appBarTitles(withTwoLines: false)[4]),
      actions: [
        ValueListenableBuilder<bool>(
          valueListenable: counterController.vibrationNotifier,
          builder: (_, value, __) {
            return IconButton(
              icon: Icon(value ? Icons.vibration : Icons.phonelink_erase),
              onPressed: () =>
                  counterController.vibrationNotifier.value = !value,
            );
          },
        ),
      ],
    );
  }
}
