import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/presentation/controller/controllers/counter_controller.dart';
import 'package:test_app/features/app/presentation/controller/controllers/featured_records_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/counter_widget.dart';
import 'package:test_app/features/app/presentation/view/components/elec_rosary_app_bar.dart';
import 'package:test_app/features/app/presentation/view/components/featured_records_widget.dart';

class ElecRosaryPage extends StatefulWidget {
  const ElecRosaryPage({super.key});

  @override
  State<ElecRosaryPage> createState() => _ElecRosaryPageState();
}

class _ElecRosaryPageState extends State<ElecRosaryPage> {
  late final FeaturedRecordsController featuredRecordsController;
  late final CounterController counterController;

  @override
  void initState() {
    super.initState();
    featuredRecordsController = FeaturedRecordsController();
    counterController =
        CounterController(featuredRecordsController.isWidgetShowedNotifier);
  }

  @override
  void dispose() {
    featuredRecordsController.dispose();
    counterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ElecRosaryAppBar(counterController: counterController),
      body: Stack(
        fit: StackFit.expand,
        children: [
          ValueListenableBuilder<bool>(
              valueListenable: featuredRecordsController.isWidgetShowedNotifier,
              child: GestureDetector(
                onTap: counterController.resetCounter,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: const CircleAvatar(
                    backgroundColor: AppColors.secondryColor,
                    radius: 10,
                  ),
                ),
              ),
              builder: (context, value, child) {
                return CounterWidget(
                  controller: counterController,
                  resetButton: child!,
                );
              }),
          BlocProvider<FeaturedRecordsCubit>(
            create: (_) => sl<FeaturedRecordsCubit>(),
            child: ValueListenableBuilder<bool>(
                valueListenable:
                    featuredRecordsController.isWidgetShowedNotifier,
                child: FeatuerdRecordsWidget(
                  controller: featuredRecordsController,
                  counterNotifier: counterController.counterNotifier,
                ),
                builder: (BuildContext context, bool value, Widget? child) {
                  return AnimatedPositioned(
                    duration: AppDurations.longDuration,
                    top: value ? 0.0 : -featuerdRecordsWidgetHight,
                    child: child!,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
