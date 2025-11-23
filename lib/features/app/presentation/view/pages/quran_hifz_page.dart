import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/widgets/custom_scaffold.dart';
import 'package:test_app/features/app/presentation/controller/cubit/hifz_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/quran_memorization_plans_widget.dart';

class QuranHifzPage extends StatefulWidget {
  const QuranHifzPage({super.key});

  @override
  State<QuranHifzPage> createState() => _QuranHifzPageState();
}

class _QuranHifzPageState extends State<QuranHifzPage> {
  final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HifzCubit>(
      create: (context) => sl<HifzCubit>()..loadPlans(),
      child: CustomScaffold(
        appBar: AppBar(
            title: Text(AppStrings.appBarTitles(withTwoLines: false)[2]),
            leading: const GetAdaptiveBackButtonWidget(
                backBehavior: BackBehavior.pop)),
        body: const QuranMemorizationPlansWidget(),
      ),
    );
  }
}
