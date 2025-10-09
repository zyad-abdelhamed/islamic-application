import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/data/models/number_animation_model.dart';
import 'package:test_app/features/app/presentation/controller/controllers/featured_records_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/features/app/presentation/view/pages/elec_rosary_page.dart';
import 'fetured_records_container.dart';

const double featuerdRecordsWidgetHight = 50 + 150 * 1.5 + 10.0;
const double showedFeatuerdRecordsWidgetButtonHight = 35;

class FeatuerdRecordsWidget extends StatelessWidget {
  const FeatuerdRecordsWidget({
    super.key,
    required this.controller,
    required this.counterNotifier,
  });

  final FeaturedRecordsController controller;
  final ValueNotifier<NumberAnimationModel> counterNotifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: isLandScapeOrientation(context)
          ? const EdgeInsets.all(0.0)
          : const EdgeInsets.only(top: 50),
      margin: isLandScapeOrientation(context)
          ? const EdgeInsets.all(0.0)
          : const EdgeInsets.only(bottom: 100),
      color: Theme.of(context).cardColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  FeaturedRecordsCubit.controller(context)
                      .addFeaturedRecord(counterNotifier.value.number);
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColorInActiveColor,
                    borderRadius: BorderRadius.circular(23),
                  ),
                  child: Icon(Icons.save,
                      color: Theme.of(context).primaryColor, size: 40),
                ),
              ),
              FeturedRecordsContainer(
                controller: controller,
                counterNotifier: counterNotifier,
              ),
            ],
          ),
          if (!isLandScapeOrientation(context))
            ShowFeaturedRecordsButton(controller: controller),
        ],
      ),
    );
  }
}

class ShowFeaturedRecordsButton extends StatelessWidget {
  const ShowFeaturedRecordsButton({
    super.key,
    required this.controller,
  });

  final FeaturedRecordsController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.toggleWidgetVisibility,
      child: SizedBox(
        width: double.infinity,
        height: showedFeatuerdRecordsWidgetButtonHight,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Divider(
            thickness: 5,
            color: const Color(0xFFE0E0E0),
            indent: 150,
            endIndent: 150,
          ),
        ),
      ),
    );
  }
}
