import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/widgets/app_divider.dart';
import 'package:test_app/core/widgets/empty_list_text_widget.dart';
import 'package:test_app/features/app/domain/entities/featured_record_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/elec_rosary_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/featured_records_cubit.dart';

class FeaturedRecordsAnimatedList extends StatelessWidget {
  const FeaturedRecordsAnimatedList({
    super.key,
    required this.controller,
  });

  final ElecRosaryPageController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: controller.recordsLengthNotifier,
      builder: (context, length, _) {
        if (length == 0) {
          return const EmptyListTextWidget();
        }
        return AnimatedList.separated(
          key: controller.listKey,
          controller: controller.scrollController,
          initialItemCount: controller.initRecords.length,
          itemBuilder: (context, index, animation) {
            final FeaturedRecordEntity item = controller.initRecords[index];

            controller.scrollToEnd(animation);

            return SizeTransition(
              sizeFactor: animation,
              child: FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: animation.drive(
                    Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).chain(CurveTween(curve: Curves.easeOut)),
                  ),
                  child: ListTile(
                    key: ValueKey(item.id),
                    title: Text(item.value.toString()),
                    trailing: IconButton(
                      icon: const Icon(
                        CupertinoIcons.delete,
                        color: AppColors.errorColor,
                      ),
                      onPressed: () {
                        FeaturedRecordsCubit.controller(context)
                            .deleteFeaturedRecord(index);
                      },
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (_, __, ___) => const AppDivider(),
          removedSeparatorBuilder: (_, __, ___) => const AppDivider(),
        );
      },
    );
  }
}
