import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/features/app/data/models/number_animation_model.dart';
import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_widget.dart';

class AdhkarPageController {
  late final ScrollController adhkarScrollController;
  late final GlobalKey<AnimatedListState> animatedLIstKey;
  late final ValueNotifier<int> lengthNotfier;
  late final ValueNotifier<double> progressNotfier;
  late final ValueNotifier<bool> switchNotfier;
  late final ValueNotifier<double> fontSizeNotfier;
  double maxProgress = 0.0;
  late final Set<AdhkarEntity> adhkar;
  void initState(BuildContext context, Set<AdhkarEntity> adhkar) {
    this.adhkar = adhkar;
    lengthNotfier = ValueNotifier<int>(adhkar.length);
    progressNotfier = ValueNotifier<double>(0.0);
    switchNotfier = ValueNotifier<bool>(true);
    fontSizeNotfier = ValueNotifier<double>(20.0);
    adhkarScrollController = ScrollController();
    animatedLIstKey = GlobalKey<AnimatedListState>();

    adhkarScrollController.addListener(() {
      maxProgress = adhkarScrollController.position.maxScrollExtent;
      progressNotfier.value = adhkarScrollController.position.pixels;
    });

    lengthNotfier.addListener(() {
      if (lengthNotfier.value == 0 && switchNotfier.value == true) {
        Future.delayed(
          AppDurations.longDuration,
          () => Navigator.pushReplacementNamed(
            context,
            RoutesConstants.homePageRouteName,
          ),
        );
      }
    });
  }

  void dispose() {
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
      _decreaseWithAnimation(countPrameters.adhkarEntity.countNotifier);
    } else if (count == 1 && switchNotfier.value) {
      _decreaseWithAnimation(countPrameters.adhkarEntity.countNotifier);

      Future.delayed(AppDurations.mediumDuration, () {
        _removeAnimation(countPrameters.index, countPrameters.adhkarEntity);
      });
    } else if (count == 1 && !switchNotfier.value) {
      _decreaseWithAnimation(countPrameters.adhkarEntity.countNotifier);

      _reduceLengthNotifierValue();
    }

    return;
  }

  void _decreaseWithAnimation(ValueNotifier<NumberAnimationModel> notifier) {
    notifier.value.slideAnimation(
      newValue: notifier.value.number - 1,
      notifier: notifier,
      slideValue: .3,
    );
  }

  void resetCount({required CountPrameters countPrameters}) {
    if (countPrameters.countNotifier.value.number !=
        countPrameters.adhkarEntity.count) {
      countPrameters.countNotifier.value.slideAnimation(
          slideValue: -.3,
          newValue: countPrameters.adhkarEntity.count,
          notifier: countPrameters.countNotifier);
      if (countPrameters.countNotifier.value.number == 0) {
        _increaseLengthNotifierValue();
      }
    }

    return;
  }

  void _removeAnimation(int index, AdhkarEntity adhkarEntity) {
    adhkar.remove(adhkarEntity);
    animatedLIstKey.currentState!.removeItem(
      duration: AppDurations.mediumDuration,
      index + 1,
      (context, animation) => SlideTransition(
        position: animation.drive(Tween<Offset>(
          begin: Offset(1, 0),
          end: Offset(0, 0),
        )),
        child: AdhkarWidget(
          key: ObjectKey(adhkarEntity),
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
