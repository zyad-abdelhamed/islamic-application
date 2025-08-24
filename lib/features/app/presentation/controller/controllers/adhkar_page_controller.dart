import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/app/data/models/number_animation_model.dart';
import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/get_adhkar_controller.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_widget.dart';

class AdhkarPageController {
  late final ScrollController adhkarScrollController;
  late final GlobalKey<AnimatedListState> animatedLIstKey;
  final ValueNotifier<int> lengthNotfier =
      ValueNotifier(sl<GetAdhkarController>().adhkar.length);
  late final ValueNotifier<double> progressNotfier;
  late final ValueNotifier<bool> switchNotfier;
  late final ValueNotifier<double> fontSizeNotfier;
  double maxProgress = 0.0;

  initState(BuildContext context) {
    progressNotfier = ValueNotifier(0.0);
    switchNotfier = ValueNotifier(true);
    fontSizeNotfier = ValueNotifier(20.0);
    adhkarScrollController = ScrollController();
    animatedLIstKey = GlobalKey<AnimatedListState>();

    adhkarScrollController.addListener(() {
      maxProgress = adhkarScrollController.position.maxScrollExtent;
      progressNotfier.value = adhkarScrollController.position.pixels;
    });
  }

  dispose() {
    lengthNotfier.dispose();
    progressNotfier.dispose();
    switchNotfier.dispose();
    fontSizeNotfier.dispose();
    adhkarScrollController.dispose();
  }

  void toggleIsDeletedSwitch() {
    if (switchNotfier.value) {
      switchNotfier.value = false;
    } else {
      switchNotfier.value = true;
    }
  }

  bool get isCircleSliderShowed => adhkarScrollController.hasClients
      ? adhkarScrollController.position.isScrollingNotifier.value
          ? true
          : false
      : false;

  void decreaseCount({required CountPrameters countPrameters}) {
    final int count = countPrameters.adhkarEntity.countNotifier.value.number;

    if (count > 1) {
      _slideAnimation(
          slideValue: .3,
          newValue: countPrameters.countNotifier.value.number - 1,
          countNotifier: countPrameters.countNotifier);
    } else if (count == 1 && switchNotfier.value) {
      _slideAnimation(
          slideValue: .3,
          newValue: countPrameters.countNotifier.value.number - 1,
          countNotifier: countPrameters.countNotifier);
      Future.delayed(AppDurations.mediumDuration, () {
        _removeAnimation(countPrameters.index, countPrameters.adhkarEntity);
      });
    } else if (count == 1 && !switchNotfier.value) {
      _slideAnimation(
          slideValue: .3,
          newValue: countPrameters.countNotifier.value.number - 1,
          countNotifier: countPrameters.countNotifier);
      _reduceLengthNotifierValue();
    }

    return;
  }

  void resetCount({required CountPrameters countPrameters}) {
    if (countPrameters.countNotifier.value.number !=
        countPrameters.adhkarEntity.count) {
      _slideAnimation(
          slideValue: -.3,
          newValue: countPrameters.adhkarEntity.count,
          countNotifier: countPrameters.countNotifier);
      if (countPrameters.countNotifier.value.number == 0) {
        _increaseLengthNotifierValue();
      }
    }

    return;
  }

  void _removeAnimation(int index, AdhkarEntity adhkarEntity) {
    sl<GetAdhkarController>().adhkar.remove(adhkarEntity);
    animatedLIstKey.currentState!.removeItem(
      duration: AppDurations.mediumDuration,
      index,
      (context, animation) => SlideTransition(
        position: animation.drive(Tween<Offset>(
          begin: Offset(1, 0),
          end: Offset(0, 0),
        )),
        child: AdhkarWidget(
          adhkarPageController: this,
          index: index,
          adhkarEntity: adhkarEntity.copyWith(
              countNotifier: ValueNotifier<NumberAnimationModel>(
                  NumberAnimationModel(number: 0))),
        ),
      ),
    );
    _reduceLengthNotifierValue();
  }

  void _reduceLengthNotifierValue() {
    lengthNotfier.value--;
  }

  void _increaseLengthNotifierValue() {
    lengthNotfier.value++;
  }

  void _slideAnimation(
      {required double slideValue,
      required int newValue,
      required ValueNotifier<NumberAnimationModel> countNotifier}) {
    countNotifier.value = NumberAnimationModel(
        number: countNotifier.value.number,
        offset: Offset(0, slideValue),
        opacity: 0.0);
    //start animation

    Future.delayed(AppDurations.lowDuration, () {
      countNotifier.value = NumberAnimationModel(number: newValue);
    }); //reverse animation and stop
  }
}

class CountPrameters {
  const CountPrameters(
      {required this.index,
      required this.countNotifier,
      required this.adhkarEntity});

  final int index;
  final ValueNotifier<NumberAnimationModel> countNotifier;
  final AdhkarEntity adhkarEntity;
}
