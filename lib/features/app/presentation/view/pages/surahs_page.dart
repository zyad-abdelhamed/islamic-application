import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/presentation/view/components/edition_drop_down_button.dart';
import 'package:test_app/features/app/presentation/view/components/tafsir_page_surahs_list_view.dart';

class SurahListPage extends StatefulWidget {
  const SurahListPage({super.key});

  @override
  State<SurahListPage> createState() => _SurahListPageState();
}

class _SurahListPageState extends State<SurahListPage> {
  late final ValueNotifier<Map<String, String>> selectedEditionNotifier;

  @override
  void initState() {
    selectedEditionNotifier = ValueNotifier<Map<String, String>>(
      {"identifier": "ar.tabari", "name": "تفسير الطبري"},
    );
    super.initState();
  }

  @override
  void dispose() {
    selectedEditionNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GetAdaptiveBackButtonWidget(),
          title: Text(AppStrings.appBarTitles(withTwoLines: false)[1]),
        ),
        body: Column(
          children: [
            TafsirEditionDropdown(
                selectedEditionNotifier: selectedEditionNotifier),
            Expanded(
                child: SurahListWithFuture(
                    selectedEditionNotifier: selectedEditionNotifier)),
          ],
        ));
  }
}
