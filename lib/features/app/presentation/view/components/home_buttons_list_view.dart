import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surahs_info_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/quran_search_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/android_and_ios_home_card_button.dart';
import 'package:test_app/features/app/presentation/view/pages/aladhkar_page.dart';
import 'package:test_app/features/app/presentation/view/pages/alquran_alkarim_page.dart';
import 'package:test_app/features/app/presentation/view/pages/elec_rosary_page.dart';
import 'package:test_app/features/app/presentation/view/pages/other_page.dart';
import 'package:test_app/features/app/presentation/view/pages/qibla_page.dart';
import 'package:test_app/features/app/presentation/view/pages/quran_hifz_page.dart';
import 'package:test_app/features/app/presentation/view/pages/quran_search_page.dart';
import 'package:test_app/features/app/presentation/view/pages/radio_stream_station.dart';
import 'package:test_app/features/app/presentation/view/pages/rtabel_page.dart';
import 'package:test_app/features/app/presentation/view/pages/surahs_page.dart';

class HomeButtonsListView extends StatelessWidget {
  const HomeButtonsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          children: List.generate(
            _pages.length,
            (index) {
              // Swap بين كل اتنين بعد أول اتنين
              int displayIndex;
              if (index > 1 && index % 2 == 0 && index + 1 < _pages.length) {
                displayIndex = index + 1;
              } else if (index > 1 && index % 2 == 1) {
                displayIndex = index - 1;
              } else {
                displayIndex = index;
              }

              // عشان كمان نبدل الأحجام
              final bool isBig;
              if (index <= 1) {
                // أول اتنين عادي
                isBig = displayIndex.isEven;
              } else {
                // بعد كده نخلي الحجم يمشي مع الـ index الأصلي مش اللي اتبدل
                isBig = index.isEven;
              }

              final double height = isBig ? 220 : 200;
              final double scale = isBig ? 0.95 : 0.85;

              return AndroidAndIosHomeCardButton(
                title:
                    AppStrings.appBarTitles(withTwoLines: false)[displayIndex],
                desc: homeButtonDescriptions[displayIndex],
                image: AppStrings.translate(
                    "imagesOfHomePageButtons")[displayIndex],
                gradientColors: _getGradiantColors(context, displayIndex),
                height: height,
                scale: scale,
                page: _pages[displayIndex],
              );
            },
          )),
    );
  }

  List<Color> _getGradiantColors(BuildContext context, int displayIndex) {
    final int length = homeButtonGradientsDarkLux.length;

    return (Theme.of(context).brightness == Brightness.dark
        ? homeButtonGradientsDarkLux
        : homeButtonGradientsLightLux)[displayIndex % length];
  }
}

const List<String?> homeButtonDescriptions = [
  "بدون انترنت", // القرآن الكريم
  "تصفح أو حمل السورة", // السور
  "ابدأ خطه جديده", // حفظ القرآن
  null, // بحث في القرآن
  null, // اذاعه القرآن الكريم
  null, // الأذكار
  null, // السبحة
  null, // جدول رمضان
  null, // القبلة
  "مزيد من الأدوات", // أخرى
];

const List<List<Color>> homeButtonGradientsDarkLux = <List<Color>>[
  [Color(0xFF336666), Color(0xFF1A3F3F)],
  [Color(0xFF5A3E7F), Color(0xFF2E1A4B)],
  [Color(0xFFB85C38), Color(0xFF7A321F)],
  [Color(0xFF997A4D), Color(0xFF5C4329)],
  [Color(0xFF3B3F5C), Color(0xFF1C1F33)],
  [Color(0xFF267373), Color(0xFF004D4D)],
  [Color(0xFF335880), Color(0xFF1A2C4D)],
  [Color(0xFF8C6173), Color(0xFF523946)],
  [Color(0xFF3E6043), Color(0xFF1B2E21)],
  [Color(0xFF52585E), Color(0xFF1C2124)],
];

const List<List<Color>> homeButtonGradientsLightLux = <List<Color>>[
  [Color(0xFF80CBC4), Color(0xFF4DB6AC)],
  [Color(0xFFB39DDB), Color(0xFF7E57C2)],
  [Color(0xFFFF8A50), Color(0xFFFF5E22)],
  [Color(0xFFFFC870), Color(0xFFFFA000)],
  [Color(0xFFBBDEFB), Color(0xFF64B5F6)],
  [Color(0xFF4DD0E1), Color(0xFF0097A7)],
  [Color(0xFF90CAF9), Color(0xFF42A5F5)],
  [Color(0xFFF8BBD0), Color(0xFFF48FB1)],
  [Color(0xFF81C784), Color(0xFF388E3C)],
  [Color(0xFF90A4AE), Color(0xFF455A64)],
];

List _pages = [
  BlocProvider<QuranCubit>(
    create: (_) => sl<QuranCubit>(),
    child: const AlquranAlkarimPage(),
  ),
  BlocProvider<GetSurahsInfoCubit>(
    create: (_) => sl<GetSurahsInfoCubit>(),
    child: const SurahListPage(),
  ),
  const QuranHifzPage(),
  BlocProvider(
    create: (context) => QuranSearchCubit(sl()),
    child: const QuranSearchPage(),
  ),
  const RadioStationPage(),
  const AlAdhkarPage(),
  const ElecRosaryPage(),
  const RamadanTabelPage(),
  const QiblaPage(),
  const OtherPage(),
];
