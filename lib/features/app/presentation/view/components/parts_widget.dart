import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/view_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_cubit.dart';

class PartsWidget extends StatelessWidget {
  const PartsWidget({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 60;

    return AnimatedContainer(
      transformAlignment: Alignment.bottomRight,
      duration: ViewConstants.mediumDuration,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
        ),
      ),
      height: height,
      width: width,
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            QuranCubit.getQuranController(context).surahPages.length,
            (index) {
              int pageNum = QuranCubit.getQuranController(context)
                      .surahPages
                      .values
                      .elementAt(index) -
                  1;

              return BlocBuilder<QuranCubit, QuranState>(
                builder: (context, state) {
                  return AnimatedContainer(
                    duration: ViewConstants.lowDuration,
                    color: index == state.cIndex
                        ? AppColors.secondryColor
                        : Colors.transparent,
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<QuranCubit>(context)
                            .changeCIndex(index); 
                        QuranCubit.getQuranController(context)
                            .goToPageByNumber(pageNum);
                      },
                      child: Text(
                        'سورة ${QuranCubit.getQuranController(context).surahPages.keys.elementAt(index)}',
                        style: TextStyles.bold20(context).copyWith(
                          color: AppColors.white,
                          fontSize: 23,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
