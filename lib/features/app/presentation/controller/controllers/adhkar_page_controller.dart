import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/constants/routes_constants.dart'
    show RoutesConstants;
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
  final ValueNotifier<double> progressNotfier = ValueNotifier(0.0);
  final ValueNotifier<bool> switchNotfier = ValueNotifier(true);
  final ValueNotifier<double> fontSizeNotfier = ValueNotifier(20.0);
  double maxProgress = 0.0;
  
  initState(BuildContext context) {
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
    animatedLIstKey.currentState!.dispose();
  }

  void increaseFontSize() {
    if (fontSizeNotfier.value <= 30.0) {
      fontSizeNotfier.value++;
    }
    return;
  }

  void decreaseFontSize() {
    if (fontSizeNotfier.value >= 10.0) {
      fontSizeNotfier.value--;
    }
    return;
  }

  void toggleIsDeletedSwitch() {
    if (switchNotfier.value) {
      switchNotfier.value = false;
    } else {
      switchNotfier.value = true;
    }
  }

  void decreaseCount({required CountPrameters countPrameters}) {
    final int count = countPrameters.adhkarEntity.countNotifier.value.number;

    if (count > 1 || (count == 1 && !switchNotfier.value)) {
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

  void _goToHomePageWhenTrminateAllItems(BuildContext context) {
    if (sl<GetAdhkarController>().adhkar.length == 1) {
      Future.delayed(Duration(milliseconds: 2100), () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
            Navigator.pushNamedAndRemoveUntil(
                context, RoutesConstants.homePageRouteName, (route) => false));
      });
    }
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
