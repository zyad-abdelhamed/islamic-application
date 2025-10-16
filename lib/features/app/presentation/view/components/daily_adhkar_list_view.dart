import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/helper_function/is_dark.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/domain/entities/daily_adhkar_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/daily_adhkar_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/daily_adhkar_state.dart';
import 'package:test_app/features/app/presentation/view/components/daily_adhkar_card.dart.dart';
import 'package:test_app/features/app/presentation/view/components/delete_alert_dialog.dart';
import 'package:test_app/features/app/presentation/view/pages/daily_adhkar_page.dart';

class DailyAdhkarListView extends StatelessWidget {
  const DailyAdhkarListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox.shrink(),

          /// زر الإضافة ثابت
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isDark(context) ? Colors.white : Colors.black)
                    .withAlpha(20)),
            child: IconButton(
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                RoutesConstants.addDailyAdhkarPage,
              ),
              icon: Icon(
                Icons.add,
                color: Colors.grey,
                size: 40,
              ),
            ),
          ),
          Expanded(
            child: BlocConsumer<DailyAdhkarCubit, DailyAdhkarState>(
              listener: (context, state) {
                if (state is DailyAdhkarError) {
                  AppSnackBar(
                          message: state.message, type: AppSnackBarType.error)
                      .show(context);
                } else if (state is DailyAdhkarDeleteSuccess) {
                  Navigator.pop(context);
                  AppSnackBar(
                          message: "تم الحذف بنجاح",
                          type: AppSnackBarType.success)
                      .show(context);

                  DailyAdhkarCubit.get(context).getAllDailyAdhkar();
                }
              },
              builder: (context, state) {
                final bool isLoading =
                    state is DailyAdhkarLoading || state is DailyAdhkarError;
                final List<DailyAdhkarEntity> adhkar =
                    state is DailyAdhkarLoaded
                        ? state.adhkar
                        : <DailyAdhkarEntity>[];

                if (adhkar.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppStrings.translate("dailyAdhkarEmptyListText"),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                final int length = adhkar.length;

                return Skeletonizer(
                  enabled: isLoading,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: length,
                    itemBuilder: (context, index) {
                      final DailyAdhkarEntity entity = adhkar[index];
                      return DailyAdhkarCard(
                        dailyAdhkarEntity: entity,
                        index: index,
                        onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DailyAdhkarPage(
                                      entities: adhkar,
                                      index: index,
                                    ))),
                        onLongPress: () => showModalBottomSheet(
                          context: context,
                          builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(CupertinoIcons.delete,
                                    color: AppColors.errorColor),
                                title: Text(
                                  "حذف",
                                  style: TextStyles.bold20(context)
                                      .copyWith(color: AppColors.errorColor),
                                ),
                                onTap: () => showDeleteAlertDialog(
                                  context,
                                  deleteFunction: () =>
                                      DailyAdhkarCubit.get(context)
                                          .deleteDailyAdhkar(index),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
