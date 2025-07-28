import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/delete_alert_dialog.dart';
import 'package:test_app/features/app/presentation/view/components/featured_records_bloc_builder.dart';

class FeturedRecordsContainer extends StatelessWidget {
  const FeturedRecordsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 150 * 1.5,
      decoration: BoxDecoration(
          color: ThemeCubit.controller(context).state
              ? AppColors.grey2
              : Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(13), topRight: Radius.circular(13)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                offset: const Offset(3, 3),
                spreadRadius: 3,
                color: Colors.grey.withValues(alpha: 0.1))
          ]),
      child: Column(
        children: [
          Divider(
            thickness: 5,
            color: Colors.grey,
            indent: 50,
            endIndent: 50,
          ),
          Center(
            child: Text(
              AppStrings.featuerdRecords,
              style: TextStyles.semiBold16_120(context)
                  .copyWith(color: AppColors.primaryColor),
            ),
          ),
          _deleteAllButton,
          Divider(),
          Expanded(child: FeaturedRecordsBlocBuilder()),
        ],
      ),
    );
  }

  BlocBuilder<FeaturedRecordsCubit, FeaturedRecordsState> get _deleteAllButton {
    return BlocBuilder<FeaturedRecordsCubit, FeaturedRecordsState>(
      buildWhen: (previous, current) =>
          current.featuredRecords.isEmpty ||
          current.featuredRecords.length == 2,
      builder: (context, state) {
        return Visibility(
          visible: state.featuredRecords.length > 1,
          child: GestureDetector(
              onTap: () => showDeleteAlertDialog(
                    context,
                    deleteFunction: () {
                      FeaturedRecordsCubit.controller(context)
                          .deleteAllFeatuerdRecords(context);
                      Navigator.pop(context);
                    },
                  ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(AppStrings.deleteAll,
                    style: TextStyles.regular14_150(context)
                        .copyWith(color: AppColors.thirdColor)),
              )),
        );
      },
    );
  }
}
