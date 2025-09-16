import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/domain/entities/ayah_search_result_entity.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_search_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_search_state.dart';
import 'package:test_app/features/app/presentation/view/components/ayahs_search_result_page_view.dart';
import 'package:test_app/features/app/presentation/view/components/erorr_widget.dart';
import 'package:test_app/features/app/presentation/view/components/recent_search_view.dart';

class QuranSearchPage extends StatefulWidget {
  const QuranSearchPage({super.key});

  @override
  State<QuranSearchPage> createState() => _QuranSearchPageState();
}

class _QuranSearchPageState extends State<QuranSearchPage> {
  final TextEditingController _controller = TextEditingController();
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final QuranSearchCubit cubit = context.read<QuranSearchCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appBarTitles(withTwoLines: false)[2]),
        leading: const GetAdaptiveBackButtonWidget(),
      ),
      body: BlocBuilder<QuranSearchCubit, QuranSearchState>(
        builder: (context, state) {
          return Column(
            children: [
              // Search input
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'ابحث عن كلمة...',
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        final String q = _controller.text.trim();
                        if (q.isEmpty) {
                          AppSnackBar(
                                  message: 'يرجى ادخال كلمة بحث',
                                  type: AppSnackBarType.info)
                              .show(context);
                          return;
                        }
                        cubit.search(q);
                      },
                    )
                  ],
                ),
              ),

              // Results area (expandable)
              Expanded(child: _buildResultSection(state, cubit)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildResultSection(QuranSearchState state, QuranSearchCubit cubit) {
    switch (state.status) {
      case QuranSearchStatus.initial:
        if (state.recentSearches.isNotEmpty) {
          return RecentSearchView(
              controller: _controller, state: state, cubit: cubit);
        }

        return const SizedBox.shrink();
      case QuranSearchStatus.loading:
        return const GetAdaptiveLoadingWidget();
      case QuranSearchStatus.failure:
        return ErrorWidgetIslamic(message: state.errorMessage!);
      case QuranSearchStatus.success:
        final List<SearchAyahEntity> ayahs =
            state.result!.ayahSearchResultEntity.ayahs;

        final Map<String, List<TafsirAyahEntity>> tafsirAyahs =
            state.result!.ayahsAllTafsir;

        return AyahsSearchResultPageView(
          pageController: _pageController,
          ayahs: ayahs,
          tafsirAyahs: tafsirAyahs,
          showExtraInfo: true,
        );
    }
  }
}
