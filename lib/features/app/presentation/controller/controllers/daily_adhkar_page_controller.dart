import 'package:flutter/material.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/app/data/datasources/daily_adhkar_local_data_source.dart';
import 'package:test_app/features/app/domain/entities/daily_adhkar_entity.dart';

class DailyAdhkarController with WidgetsBindingObserver {
  final TickerProvider vsync;
  final BuildContext context;
  final DailyAdhkarEntity entity;
  final int index;

  late final AnimationController controller;
  final ValueNotifier<bool> isPausedByUser = ValueNotifier(false);

  bool _isLifecyclePaused = false;

  DailyAdhkarController({
    required this.vsync,
    required this.context,
    required this.entity,
    required this.index,
  }) {
    if (entity.isShowed == false) {
      sl<BaseDailyAdhkarLocalDataSource>().markAsShown(index);
    }

    WidgetsBinding.instance.addObserver(this);

    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 30),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          back();
        }
      });

    controller.forward();
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.dispose();
    isPausedByUser.dispose();
  }

  void pause() {
    if (controller.isAnimating) {
      controller.stop();
    }
  }

  void resume() {
    if (!controller.isAnimating &&
        !isPausedByUser.value &&
        !_isLifecyclePaused) {
      controller.forward();
    }
  }

  void onLongPress() {
    isPausedByUser.value = true;
    pause();
  }

  void onLongPressEnd(LongPressEndDetails _) {
    isPausedByUser.value = false;
    resume();
  }

  void back() {
    Navigator.pushReplacementNamed(context, RoutesConstants.homePageRouteName);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _isLifecyclePaused = true;
      pause();
    } else if (state == AppLifecycleState.resumed) {
      _isLifecyclePaused = false;
      resume();
    }
  }
}
