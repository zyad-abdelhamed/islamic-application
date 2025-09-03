import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/constants/routes_constants.dart';
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
      height: 130,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// زر الإضافة ثابت
          CircleAvatar(
            radius: circleSize / 2,
            backgroundColor: Colors.grey.withAlpha(30),
            child: IconButton(
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                RoutesConstants.addDailyAdhkarPage,
              ),
              icon: const Icon(
                Icons.add,
                color: Colors.grey,
                size: 30,
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
                        onLongPress: () => showDeleteAlertDialog(
                          context,
                          content: Text("اضغط نعم للحذف"),
                          deleteFunction: () => DailyAdhkarCubit.get(context)
                              .deleteDailyAdhkar(index),
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
