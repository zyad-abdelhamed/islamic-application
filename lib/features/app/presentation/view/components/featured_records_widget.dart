import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/data/models/number_animation_model.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/fetured_records_container.dart';

const double featuerdRecordsWidgetHight = 50 + 150 * 1.5 + 10.0;
const double showedFeatuerdRecordsWidgetButtonHight = 35;

class FeatuerdRecordsWidget extends StatelessWidget {
  const FeatuerdRecordsWidget({
    super.key,
    required this.counterNotifier,
    required this.isfeatuerdRecordsWidgetShowedNotifier,
  });

  final ValueNotifier<NumberAnimationModel> counterNotifier;
  final ValueNotifier<bool> isfeatuerdRecordsWidgetShowedNotifier;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: AppDurations.longDuration,
      top: _getTopPositioned,
      child: Container(
        width: context.width,
        padding: const EdgeInsets.only(top: 50),
        margin: const EdgeInsets.only(bottom: 100),
                    color: AppColors.grey1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _saveButton(context),
                FeturedRecordsContainer(),
              ],
            ),
            _showedControllerButton(context)
          ],
        ),
      ),
    );
  }

  double get _getTopPositioned => isfeatuerdRecordsWidgetShowedNotifier.value
      ? 0.0
      : -(featuerdRecordsWidgetHight);

  GestureDetector _saveButton(BuildContext context) {
    return GestureDetector(
      onTap: () => FeaturedRecordsCubit.controller(context).addFeatuerdRecord(
          counterNotifier: counterNotifier, context: context),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: AppColors.inActivePrimaryColor,
            borderRadius: BorderRadius.circular(23)),
        child: Icon(
          Icons.save,
          color: Theme.of(context).primaryColor,
          size: 40,
        ),
      ),
    );
  }

  Widget _showedControllerButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      isfeatuerdRecordsWidgetShowedNotifier.value =
          !isfeatuerdRecordsWidgetShowedNotifier.value;
    },
    child:  SizedBox(
      width: double.infinity,
      height: showedFeatuerdRecordsWidgetButtonHight,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Divider(
          thickness: 5,
          color: Color(0xFFE0E0E0),
          indent: context.width * .40,
          endIndent: context.width * .40,
        ),
      ),
    ),
  );
}

}
