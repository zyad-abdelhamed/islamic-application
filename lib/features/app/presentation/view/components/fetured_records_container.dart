import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/controller/controllers/featured_records_controller.dart';
import 'package:test_app/features/app/presentation/view/components/delete_all_featured_records_button.dart';
import 'package:test_app/features/app/presentation/view/components/featured_recordes_bloc_listener.dart';
import 'package:test_app/features/app/presentation/view/components/rolling_counter.dart';

class FeturedRecordsContainer extends StatelessWidget {
  const FeturedRecordsContainer({
    super.key,
    required this.controller,
    required this.counterKey,
  });

  final FeaturedRecordsController controller;
  final GlobalKey<RollingCounterState> counterKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 150 * 1.5,
      decoration: _boxDecoration(context),
      child: Column(
        children: [
          const Divider(
              thickness: 5, color: Colors.grey, indent: 50, endIndent: 50),
          Center(
            child: Text(
              AppStrings.translate("featuerdRecords"),
              style: TextStyles.semiBold16_120(context),
            ),
          ),
          DeleteAllFeaturedRecordsButton(
            controller: controller,
          ),
          const Divider(),
          Expanded(
            child: FeaturedRecordesBlocListener(
              controller: controller,
              counterKey: counterKey,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.grey2
          : Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(13),
        topRight: Radius.circular(13),
      ),
      boxShadow: Theme.of(context).brightness == Brightness.dark
          ? []
          : [
              BoxShadow(
                offset: const Offset(3, 3),
                spreadRadius: 3,
                color: Colors.grey.withValues(alpha: 0.1),
              )
            ],
    );
  }
}
