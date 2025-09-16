import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_search_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_search_state.dart';

class RecentSearchView extends StatelessWidget {
  const RecentSearchView({
    super.key,
    required this.controller,
    required this.state,
    required this.cubit,
  });

  final TextEditingController controller;
  final QuranSearchState state;
  final QuranSearchCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Text(
              "الأخيرة",
            ),
          ),
          Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              ...state.recentSearches.map((q) {
                return InputChip(
                  label: Text(
                    q,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    controller.text = q;
                    cubit.search(q);
                  },
                  deleteIconColor: AppColors.errorColor,
                  onDeleted: () {
                    cubit.removeRecent(q);
                  },
                );
              }),
              TextButton(
                onPressed: () => cubit.clearRecents(),
                child: const Text('مسح الكل'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
