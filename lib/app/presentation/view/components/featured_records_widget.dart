import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/app/presentation/view/components/erorr_widget.dart';
import 'package:test_app/core/constants/view_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class FeatuerdRecordsWidget extends StatelessWidget {
  const FeatuerdRecordsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * .40,
      height: (context.width * .40) * 1.5,
      margin: const EdgeInsets.only(bottom: 35.0),
      decoration: BoxDecoration(
        color: AppColors.grey2,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(13), topRight: Radius.circular(13)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 7,
                left: context.width * .10,
                right: context.width * .10,
                bottom: 10),
            child: Divider(
              thickness: 5,
              color: Colors.grey,
            ),
          ),
          Center(
            child: Text(
              'الريكوردات المميزه',
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {},
                  child: Text('  حذف الكل',
                      style: TextStyles.regular14_150(context)
                          .copyWith(color: AppColors.thirdColor))),
              Divider(),
            ],
          ),

          Expanded(
            child: BlocBuilder<FeaturedRecordsCubit, FeaturedRecordsState>(
              builder: (context, state) {
                print('Featured Records rebuild');
                if (state.featuredRecordsRequestState ==
                    RequestStateEnum.failed) {
                  return ErorrWidget(message: state.featuredRecordsErrorMessage!);
                }

                //case  success or loading
                return state.featuredRecords.isNotEmpty
                    ? ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider(
                            thickness: 0.5,
                          );
                        },
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.featuredRecords.length,
                        itemBuilder: (context, index) {
                          return Text(
                            state.featuredRecords[index].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyles.bold20(context),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                        ViewConstants.emptyList,
                        style: TextStyles.regular16_120(context,
                            color: AppColors.secondryColor),
                      ));
              },
            ),
          ),
          // )
        ],
      ),
    );
  }
}

