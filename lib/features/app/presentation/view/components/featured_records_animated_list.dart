import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/widgets/app_divider.dart';
import 'package:test_app/core/widgets/empty_list_text_widget.dart';
import 'package:test_app/features/app/domain/entities/featured_record_entity.dart';
import 'package:test_app/features/app/presentation/controller/controllers/featured_records_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/delete_alert_dialog.dart';

class FeaturedRecordsAnimatedList extends StatelessWidget {
  const FeaturedRecordsAnimatedList({
    super.key,
    required this.controller,
  });

  final FeaturedRecordsController controller;

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
          physics: const BouncingScrollPhysics(),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      key: ValueKey(item.id),
                      children: [
                        Text(
                          item.value.toString(),
                          style: TextStyles.semiBold18(context, Colors.black)
                              .copyWith(fontFamily: 'DataFontFamily'),
                        ),
                        GestureDetector(
                          child: const Icon(
                            CupertinoIcons.delete,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            showDeleteAlertDialog(context, deleteFunction: () {
                              Navigator.pop(context);
                              FeaturedRecordsCubit.controller(context)
                                  .deleteFeaturedRecord(index);
                            });
                          },
                        )
                      ],
                    )),
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
