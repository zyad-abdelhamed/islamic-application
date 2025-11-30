import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/features/app/domain/entities/adhkar_entity.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_widget.dart';
import 'package:test_app/features/app/presentation/view/components/rolling_counter.dart';

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
          () {
            if (context.mounted) {
              Navigator.pushReplacementNamed(
                context,
                RoutesConstants.homePageRouteName,
              );
            }
          },
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
    switchNotfier.value = !switchNotfier.value;
  }

  bool get isCircleSliderShowed => adhkarScrollController.hasClients
      ? adhkarScrollController.position.isScrollingNotifier.value
      : false;

  void decreaseCount({required CountPrameters countPrameters}) {
    final counter = countPrameters.counterKey.currentState;
    final int count = counter?.value ?? 0;

    if (count > 1) {
      counter?.decrease(1.0);
    } else if (count == 1 && switchNotfier.value) {
      counter?.decrease(1.0);
      Future.delayed(AppDurations.mediumDuration, () {
        _removeAnimation(countPrameters.index, countPrameters.adhkarEntity);
      });
    } else if (count == 1 && !switchNotfier.value) {
      counter?.decrease(1.0);
      _reduceLengthNotifierValue();
    }
  }

  void resetCount({required CountPrameters countPrameters}) {
    final counter = countPrameters.counterKey.currentState;
    final int current = counter?.value ?? 0;
    final int target = countPrameters.adhkarEntity.count;

    if (current != target) {
      counter?.reset(target);
      if (current == 0) {
        _increaseLengthNotifierValue();
      }
    }
  }

  void _removeAnimation(int index, AdhkarEntity adhkarEntity) {
    adhkar.remove(adhkarEntity);

    animatedLIstKey.currentState!.removeItem(
      index + 1,
      duration: AppDurations.mediumDuration,
      (context, animation) => SlideTransition(
        position: animation.drive(Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        )),
        child: AdhkarWidget(
          key: ObjectKey(adhkarEntity),
          adhkarPageController: this,
          index: index,
          adhkarEntity: adhkarEntity,
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
  const CountPrameters({
    required this.index,
    required this.counterKey,
    required this.adhkarEntity,
  });

  final int index;
  final GlobalKey<RollingCounterState> counterKey;
  final AdhkarEntity adhkarEntity;
}
