import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/presentation/controller/controllers/counter_controller.dart';
import 'package:test_app/features/app/presentation/controller/controllers/featured_records_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/counter_widget.dart';
import 'package:test_app/features/app/presentation/view/components/elec_rosary_app_bar.dart';
import 'package:test_app/features/app/presentation/view/components/featured_records_widget.dart';

/// helper function
bool isLandScapeOrientation(BuildContext context) =>
    MediaQuery.of(context).orientation == Orientation.landscape;

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
      body: isLandScapeOrientation(context)
          ? LandscapeLayout(
              counterController: counterController,
              featuredRecordsController: featuredRecordsController,
            )
          : PortraitLayout(
              counterController: counterController,
              featuredRecordsController: featuredRecordsController,
            ),
    );
  }
}

/// Portrait UI
class PortraitLayout extends StatelessWidget {
  final CounterController counterController;
  final FeaturedRecordsController featuredRecordsController;

  const PortraitLayout({
    super.key,
    required this.counterController,
    required this.featuredRecordsController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
          },
        ),
        BlocProvider<FeaturedRecordsCubit>(
          create: (_) => sl<FeaturedRecordsCubit>(),
          child: ValueListenableBuilder<bool>(
            valueListenable: featuredRecordsController.isWidgetShowedNotifier,
            child: FeatuerdRecordsWidget(
              controller: featuredRecordsController,
              counterNotifier: counterController.counterNotifier,
            ),
            builder: (context, value, child) {
              return AnimatedPositioned(
                duration: AppDurations.longDuration,
                top: value ? 0.0 : -featuerdRecordsWidgetHight,
                child: child!,
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Landscape UI
class LandscapeLayout extends StatelessWidget {
  final CounterController counterController;
  final FeaturedRecordsController featuredRecordsController;

  const LandscapeLayout({
    super.key,
    required this.counterController,
    required this.featuredRecordsController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Positioned(
            left: context.width * .20,
            right: context.width * .20,
            child: ValueListenableBuilder<bool>(
              valueListenable: featuredRecordsController.isWidgetShowedNotifier,
              child: GestureDetector(
                onTap: counterController.resetCounter,
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: CircleAvatar(
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
              },
            ),
          ),
        ),

        /// زر التحكم في السجلات (الهاندل الجانبي)
        ValueListenableBuilder<bool>(
          valueListenable: featuredRecordsController.isWidgetShowedNotifier,
          builder: (context, isVisible, child) {
            return AnimatedPositioned(
              duration: AppDurations.longDuration,
              top: 0,
              bottom: 0,
              left: !isVisible ? 0 : 350,
              child: GestureDetector(
                onTap: featuredRecordsController.toggleWidgetVisibility,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 20,
                    height: context.height,
                    color: Theme.of(context).cardColor,
                    child: Center(
                      child: Container(
                        width: 5,
                        height: 60,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        /// السجلات ناحية الشمال وتظهر بالأنيميشن
        BlocProvider<FeaturedRecordsCubit>(
          create: (_) => sl<FeaturedRecordsCubit>(),
          child: ValueListenableBuilder<bool>(
            valueListenable: featuredRecordsController.isWidgetShowedNotifier,
            builder: (context, isVisible, child) {
              return AnimatedPositioned(
                duration: AppDurations.longDuration,
                top: 0,
                bottom: 0,
                left: isVisible ? 0 : -350,
                child: SizedBox(
                  width: 350,
                  child: FeatuerdRecordsWidget(
                    controller: featuredRecordsController,
                    counterNotifier: counterController.counterNotifier,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
