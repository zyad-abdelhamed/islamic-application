import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/features/app/presentation/controller/controllers/featured_records_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/featured_records_state.dart';
import 'package:test_app/features/app/presentation/view/components/erorr_widget.dart';
import 'package:test_app/features/app/presentation/view/components/featured_records_animated_list.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/presentation/view/components/rolling_counter.dart';

class FeaturedRecordesBlocListener extends StatelessWidget {
  const FeaturedRecordesBlocListener({
    super.key,
    required this.controller,
    required this.counterKey,
  });

  final FeaturedRecordsController controller;
  final GlobalKey<RollingCounterState> counterKey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeaturedRecordsCubit, FeaturedRecordsState>(
      listener: (_, state) {
        if (state is FeaturedRecordsLoaded) {
          controller.initRecords = state.featuredRecords;
          controller.recordsLengthNotifier.value =
              controller.initRecords.length;
        } else if (state is FeaturedRecordsAddSuccess) {
          counterKey.currentState?.reset(0);
          controller.addAnimation(newRecord: state.newRecord);

          AppSnackBar(
            message: "تم اضافة الريكورد بنجاح",
            type: AppSnackBarType.success,
          ).show(context);
        } else if (state is FeaturedRecordsDeleteSuccess) {
          controller.removeAnimation(context, state.deletedIndex);

          AppSnackBar(
            message: "تم حذف الريكورد بنجاح",
            type: AppSnackBarType.success,
          ).show(context);
        } else if (state is FeaturedRecordsClearSuccess) {
          controller.removeAllItems();

          AppSnackBar(
            message: "تم حذف جميع الريكوردات المميزة",
            type: AppSnackBarType.success,
          ).show(context);
        } else if (state is FeaturedRecordsFunctionlityError) {
          AppSnackBar(
            message: state.message,
            type: AppSnackBarType.error,
          ).show(context);
        }
      },
      buildWhen: (_, current) =>
          current is FeaturedRecordsLoaded ||
          current is FeaturedRecordsLoading ||
          current is LoadFeaturedRecordsError,
      builder: (_, state) {
        if (state is FeaturedRecordsLoading) {
          return const AppLoadingWidget();
        } else if (state is LoadFeaturedRecordsError) {
          return FittedBox(
            fit: BoxFit.scaleDown,
            child: ErrorWidgetIslamic(message: state.message),
          );
        } else if (state is FeaturedRecordsLoaded) {
          return FeaturedRecordsAnimatedList(controller: controller);
        }
        return const AppLoadingWidget();
      },
    );
  }
}
