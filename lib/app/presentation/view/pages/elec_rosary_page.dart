import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app/presentation/controller/cubit/elec_rosary_cubit.dart';
import 'package:test_app/app/presentation/view/components/counter_widget.dart';
import 'package:test_app/app/presentation/view/components/featured_records_widget.dart';
import 'package:test_app/app/presentation/view/components/pages_app_bar.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class ElecRosaryPage extends StatelessWidget {
  const ElecRosaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      BlocProvider(create: (context) => ElecRosaryCubit()),
    ],
      child: Scaffold(
          appBar: pagesAppBar[1],
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: context.width * .50),
                child: FeatuerdRecordsWidget(),
              ),
              CounterWidget(),
              MaterialButton(
                onPressed: () {},
                color: AppColors.primaryColor,
                child: Text('حفظ',
                    style: TextStyles.semiBold20(context)
                        .copyWith(color: AppColors.white)),
              ),
            ],
          )),
    );
  }
}