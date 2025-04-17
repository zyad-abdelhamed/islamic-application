import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/app/presentation/controller/cubit/elec_rosary_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/counter_widget.dart';
import 'package:test_app/features/app/presentation/view/components/featured_records_widget.dart';
import 'package:test_app/features/app/presentation/view/components/pages_app_bar.dart';
import 'package:test_app/core/adaptive_widgets/adaPtive_layout.dart';
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
        child: AdaptiveLayout(
            mobileLayout: (context) => ElecRosaryMobileLayout(),
            tabletLayout: (context) => ElecRosaryTabletAndWindowsLayout(),
            desktopLayout: (context) => ElecRosaryTabletAndWindowsLayout()));
  }
}

class ElecRosaryMobileLayout extends StatelessWidget {
  const ElecRosaryMobileLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: pagesAppBar[1],
        body: Center(
          child: Column(
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
          ),
        ));
  }
}

class ElecRosaryTabletAndWindowsLayout extends StatelessWidget {
  const ElecRosaryTabletAndWindowsLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: pagesAppBar[1],
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CounterWidget(),
              FeatuerdRecordsWidget(),
            ],
          ),
        ));
  }
}
