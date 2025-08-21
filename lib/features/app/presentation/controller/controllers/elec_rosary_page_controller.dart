import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/data/models/number_animation_model.dart';
import 'package:test_app/features/app/domain/entities/featured_record_entity.dart'; // هنا بنستعمل الـ Entity

class ElecRosaryPageController {
  late final GlobalKey<AnimatedListState> listKey;
  late List<FeaturedRecordEntity> initRecords;
  late final ScrollController scrollController;

  /// Notifiers
  late final ValueNotifier<NumberAnimationModel> counterNotifier;
  late final ValueNotifier<bool> isWidgetShowedNotifier;
  late final ValueNotifier<int> recordsLengthNotifier;

  initState() {
    listKey = GlobalKey<AnimatedListState>();
    initRecords = [];
    scrollController = ScrollController();
    counterNotifier = ValueNotifier(NumberAnimationModel(number: 0));
    isWidgetShowedNotifier = ValueNotifier(false);
    recordsLengthNotifier = ValueNotifier(0);
  }

  
 void scrollToEnd(Animation<double> animation) {
  /// هذا الميثود ضروري جداً
  /// لو حاولنا نعمل حركة السكروول جوه addAnimation
  /// ماكنتش بتظبط
  /// السبب إن maxScrollExtent وقت الإضافة بيكون لسه ما اتحسبش صح
  /// لأن العنصر الجديد لسه ماخدش ارتفاعه النهائي
  /// لكن لما نسمع للانيميشن نفسه، بنستفيد إن الانيميشن بيتحدث مع كل فريم
  /// وبالتالي نقدر نعمل jumpTo لأحدث قيمة من maxScrollExtent بالتزامن مع دخول العنصر

  void listener() {
    // Calls the listener every time the value of the animation changes
    if (scrollController.hasClients) {
      scrollController.jumpTo(
        scrollController.position.maxScrollExtent,
      );
    }
  }

  animation.addListener(listener);

  // يشيل الليسنر أوتوماتيك بعد الإنيميشن يخلص
  animation.addStatusListener((status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      animation.removeListener(listener);
    }
  });
}


  void addAnimation({required FeaturedRecordEntity newRecord}) {
    final int newIndex = initRecords.length;

    initRecords.add(newRecord);

    listKey.currentState?.insertItem(
      newIndex,
      duration: AppDurations.mediumDuration,
    );

    Future.delayed(AppDurations.mediumDuration, () {
      recordsLengthNotifier.value++;
    });
  }

  void removeAnimation(BuildContext context, int deletedIndex) {
    final record = initRecords[deletedIndex];

    initRecords.removeAt(deletedIndex);

    listKey.currentState?.removeItem(
      deletedIndex,
      (_, animation) => SizeTransition(
        sizeFactor: animation,
        child: ListTile(
          key: ValueKey(record.id),
          title: Text(
            "تم حذف الريكورد (${record.value})",
            style: TextStyles.regular14_150(context)
                .copyWith(color: AppColors.errorColor),
          ),
        ),
      ),
      duration: AppDurations.mediumDuration,
    );

    Future.delayed(AppDurations.mediumDuration, () {
      recordsLengthNotifier.value--;
    });
  }

  void removeAllItems() {
    listKey.currentState?.removeAllItems(
      duration: AppDurations.mediumDuration,
      (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: ListTile(
            title: Text(
              "تم الحذف",
              style: TextStyles.regular14_150(context).copyWith(
                color: AppColors.errorColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );

    // بعد ما يخلص الانيميشن نفرّغ الليست
    Future.delayed(AppDurations.mediumDuration, () {
      initRecords.clear();

      ///  ماينفعش نفرّغ initRecords قبل الانيميشن (هيكراش).
      ///  لازم نستنى مدة الانيميشن وبعدها نفرّغ الليست.

      recordsLengthNotifier.value = 0;
    });
  }

  /// Toggle widget visibility
  void toggleWidgetVisibility() {
    isWidgetShowedNotifier.value = !isWidgetShowedNotifier.value;
  }

  void dispose() {
    counterNotifier.dispose();
    isWidgetShowedNotifier.dispose();
    recordsLengthNotifier.dispose();
    scrollController.dispose();
  }
}
