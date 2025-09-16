import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/features/app/domain/entities/tafsir_ayah_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surah_with_tafsir_state.dart';
import 'package:test_app/features/app/domain/entities/ayah_entity.dart';
import 'package:test_app/features/app/presentation/view/components/ayahs_search_result_page_view.dart';

class QAndAPage extends StatefulWidget {
  const QAndAPage({super.key, required this.cubit});

  final GetSurahWithTafsirCubit cubit;

  @override
  State<QAndAPage> createState() => _QAndAPageState();
}

class _QAndAPageState extends State<QAndAPage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.cubit,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 150.0),
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => widget.cubit.search(value),
              decoration: InputDecoration(
                prefixIcon: const GetAdaptiveBackButtonWidget(
                    backBehavior: BackBehavior.pop),
                hintText: "ابحث عن الآية...",
              ),
            ),
          )),
        ),
        body: BlocBuilder<GetSurahWithTafsirCubit, GetSurahWithTafsirState>(
          builder: (context, state) {
            if (state is GetSurahWithTafsirSearchState) {
              final List<AyahEntity> ayahs = state.ayahs;
              final Map<String, List<TafsirAyahEntity>> tafsirAyahs =
                  state.tafsirAyahs;

              return AyahsSearchResultPageView(
                pageController: _pageController,
                ayahs: ayahs,
                tafsirAyahs: tafsirAyahs,
                showExtraInfo: false,
              );
            } else if (state is GetSurahWithTafsirSearchNotFoundDataState) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
