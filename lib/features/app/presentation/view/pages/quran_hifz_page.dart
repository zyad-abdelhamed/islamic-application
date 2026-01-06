import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/widgets/cancel_button.dart';
import 'package:test_app/features/app/presentation/view/components/delete_alert_dialog.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
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

  /// ===== Selection =====
  final List<String> selectedPlans = [];

  void _exitSelectionMode() {
    setState(() {
      selectedPlans.clear();
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HifzCubit>();

    return CustomScaffold(
      appBar: AppBar(
        title: Text(
          selectedPlans.isEmpty
              ? AppStrings.appBarTitles(withTwoLines: false)[2]
              : 'تم تحديد ${selectedPlans.length}',
        ),
        leading: selectedPlans.isNotEmpty
            ? CancelButton(onTap: _exitSelectionMode)
            : const GetAdaptiveBackButtonWidget(backBehavior: BackBehavior.pop),
        actions: [
          if (selectedPlans.isNotEmpty)
            IconButton(
              icon: const Icon(CupertinoIcons.delete, color: Colors.red),
              onPressed: () =>
                  showDeleteAlertDialog(context, deleteFunction: () async {
                cubit.deletePlans(selectedPlans.toList());
                _exitSelectionMode();
              }),
            ),
        ],
      ),
      body: QuranMemorizationPlansWidget(
        selectedPlans: selectedPlans,
        onSelectionChanged: () => setState(() {}),
      ),
    );
  }
}
