import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/presentation/controller/cubit/elec_rosary_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/counter_widget.dart';
import 'package:test_app/features/app/presentation/view/components/featured_records_widget.dart';
import 'package:test_app/core/adaptive/adaPtive_layout.dart';
import 'package:test_app/core/services/dependency_injection.dart';

class ElecRosaryPage extends StatelessWidget {
  const ElecRosaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ElecRosaryCubit()),
          BlocProvider(
              create: (context) => FeaturedRecordsCubit(sl(), sl(), sl(), sl())
                ..getFeatuerdRecords()),
        ],
        child: Scaffold(
          appBar: AppBar(
            leading: GetAdaptiveBackButtonWidget(),
            title: Text(AppStrings.appBarTitles(withTwoLines: false)[1]),
          ),
          body: AdaptiveLayout(
              mobileLayout: (context) => getElecRosaryMobileLayout,
              tabletLayout: (context) => getElecRosaryTabletAndDesktopLayout,
              desktopLayout: (context) => getElecRosaryTabletAndDesktopLayout),
        ));
  }

  Column get getElecRosaryMobileLayout => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Spacer(),
              Spacer(),
              Spacer(),
              Spacer(),
              FeatuerdRecordsWidget(),
              Spacer()
            ],
          ),
          CounterWidget(),
        ],
      );

  Center get getElecRosaryTabletAndDesktopLayout => Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CounterWidget(),
          FeatuerdRecordsWidget(),
        ],
      ));
}
