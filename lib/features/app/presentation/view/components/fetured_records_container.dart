import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/controller/controllers/elec_rosary_page_controller.dart';
import 'package:test_app/features/app/presentation/view/components/delete_all_featured_records_button.dart';
import 'package:test_app/features/app/presentation/view/components/featured_recordes_bloc_listener.dart';

class FeturedRecordsContainer extends StatelessWidget {
  const FeturedRecordsContainer({super.key, required this.controller});

  final ElecRosaryPageController controller;

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
              style: TextStyles.semiBold16_120(context)
                  .copyWith(color: ThemeCubit.controller(context).state ? AppColors.darkModeTextColor : AppColors.lightModePrimaryColor),
            ),
          ),
          DeleteAllFeaturedRecordsButton(
            controller: controller,
          ),
          const Divider(),
          Expanded(
            child: FeaturedRecordesBlocListener(controller: controller),
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration(BuildContext context) {
    return BoxDecoration(
      color:
          ThemeCubit.controller(context).state ? AppColors.grey2 : Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(13),
        topRight: Radius.circular(13),
      ),
      boxShadow: ThemeCubit.controller(context).state
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