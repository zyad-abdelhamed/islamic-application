import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/data/models/number_animation_model.dart';
import 'package:test_app/features/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/counter_widget.dart';
import 'package:test_app/features/app/presentation/view/components/featured_records_widget.dart';
import 'package:test_app/core/services/dependency_injection.dart';

const double counterWidetDefaultMargin =
    showedFeatuerdRecordsWidgetButtonHight + 20;

class ElecRosaryPage extends StatefulWidget {
  const ElecRosaryPage({super.key});

  @override
  State<ElecRosaryPage> createState() => _ElecRosaryPageState();
}

class _ElecRosaryPageState extends State<ElecRosaryPage> {
  late final ValueNotifier<NumberAnimationModel> counterNotifier;
  late final ValueNotifier<bool> isfeatuerdRecordsWidgetShowedNotifier;

  @override
  void initState() {
    counterNotifier =
        ValueNotifier<NumberAnimationModel>(NumberAnimationModel(number: 0));
    isfeatuerdRecordsWidgetShowedNotifier =
        ValueNotifier<bool>(false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            FeaturedRecordsCubit(sl(), sl(), sl(), sl())..getFeatuerdRecords(),
        child: Scaffold(
          appBar: AppBar(
            leading: GetAdaptiveBackButtonWidget(),
            title: Text(AppStrings.appBarTitles(withTwoLines: false)[2]),
          ),
          body: ValueListenableBuilder<bool>(
            valueListenable: isfeatuerdRecordsWidgetShowedNotifier,
            builder: (_, __, ___) => Stack(
              fit: StackFit.expand,
              children: [
                CounterWidget(
                  counterNotifier: counterNotifier, isfeatuerdRecordsWidgetShowedNotifier: isfeatuerdRecordsWidgetShowedNotifier,
                ),
                FeatuerdRecordsWidget(
                  counterNotifier: counterNotifier,
                  isfeatuerdRecordsWidgetShowedNotifier: isfeatuerdRecordsWidgetShowedNotifier,
                )
              ],
            ),
          ),
        ));
  }
}
