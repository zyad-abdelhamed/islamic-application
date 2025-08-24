import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/home_button.dart';
import 'package:test_app/features/app/presentation/view/pages/alquran_alkarim_page.dart';
import 'package:test_app/features/app/presentation/view/pages/elec_rosary_page.dart';
import 'package:test_app/features/app/presentation/view/pages/other_page.dart';
import 'package:test_app/features/app/presentation/view/pages/qibla_page.dart';
import 'package:test_app/features/app/presentation/view/pages/rtabel_page.dart';
import 'package:test_app/features/app/presentation/view/pages/surahs_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/services/dependency_injection.dart';

class HomeButtonsListView extends StatelessWidget {
  const HomeButtonsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: _pages.length,
        itemBuilder: (context, index) => HomeButton(
          text: AppStrings.appBarTitles(withTwoLines: true)[index],
          index: index,
          page: _pages[index],
          image: AppStrings.translate("imagesOfHomePageButtons")[index],
        ),
      ),
    );
  }
}

List _pages = [
  BlocProvider<QuranCubit>(
    create: (context) => sl<QuranCubit>(),
    child: AlquranAlkarimPage(),
  ),
  SurahListPage(),
  ElecRosaryPage(),
  RamadanTabelPage(),
  QiblaPage(),
  OtherPage(),
];
