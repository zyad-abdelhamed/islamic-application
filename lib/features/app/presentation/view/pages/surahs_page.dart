import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/presentation/view/components/surahs_search_text_filed.dart';
import 'package:test_app/features/app/presentation/view/components/tafsir_page_surahs_list_view.dart';

class SurahListPage extends StatefulWidget {
  const SurahListPage({super.key});

  @override
  State<SurahListPage> createState() => _SurahListPageState();
}

class _SurahListPageState extends State<SurahListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const GetAdaptiveBackButtonWidget(),
          title: Text(AppStrings.appBarTitles(withTwoLines: false)[1]),
          bottom: const TabBar(
            isScrollable: false,
            dividerColor: Colors.transparent,
            indicatorColor: AppColors.lightModePrimaryColor,
            labelColor: AppColors.lightModePrimaryColor,
            tabAlignment: TabAlignment.center,
            tabs: [
              Tab(text: "جميع السور"),
              Tab(text: "المحفوظة"),
              Tab(text: "غير المحفوظة"),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            /// جميع السور (فيها البحث)
            Column(
              children: const [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SurahsSearchTextFiled(),
                ),
                Expanded(
                  child: TafsirPageSurahsListView(),
                ),
              ],
            ),

            /// المحفوظة
            const TafsirPageSurahsListView(
              showOnlyDownloaded: true,
            ),

            /// غير المحفوظة
            const TafsirPageSurahsListView(
              showOnlyNotDownloaded: true,
            ),
          ],
        ),
      ),
    );
  }
}
