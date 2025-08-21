import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/app/presentation/controller/controllers/elec_rosary_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/counter_widget.dart';
import 'package:test_app/features/app/presentation/view/components/featured_records_widget.dart';

class ElecRosaryPage extends StatefulWidget {
  const ElecRosaryPage({super.key});

  @override
  State<ElecRosaryPage> createState() => _ElecRosaryPageState();
}

class _ElecRosaryPageState extends State<ElecRosaryPage> {
  late final ElecRosaryPageController controller;

  @override
  void initState() {
    super.initState();
    controller = ElecRosaryPageController();
    controller.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const GetAdaptiveBackButtonWidget(),
        title: Text(AppStrings.appBarTitles(withTwoLines: false)[2]),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: controller.isWidgetShowedNotifier,
        builder: (_, __, ___) => Stack(
          fit: StackFit.expand,
          children: [
            CounterWidget(
              counterNotifier: controller.counterNotifier,
              isfeatuerdRecordsWidgetShowedNotifier:
                  controller.isWidgetShowedNotifier,
            ),
            BlocProvider<FeaturedRecordsCubit>(
              create: (_) => sl<FeaturedRecordsCubit>(),
              child: FeatuerdRecordsWidget(controller: controller),
            ),
          ],
        ),
      ),
    );
  }
}
