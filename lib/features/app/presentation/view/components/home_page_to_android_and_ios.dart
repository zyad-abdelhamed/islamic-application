import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_grid_view.dart';
import 'package:test_app/features/app/presentation/view/components/home_button.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_drawer.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/features/app/presentation/view/components/prayer_times_widget.dart';
import 'package:test_app/features/duaa/presentation/controllers/cubit/duaa_cubit.dart';

class HomePageToAndroidAndIos extends StatelessWidget {
  const HomePageToAndroidAndIos({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final bool isPortraitOrientation =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.translate("mainPage")),
        ),
        drawer: Drawer(
            child: BlocProvider(
          create: (context) => DuaaCubit(sl())..getDuaa(),
          child: HomeDrawerWidget(),
        )),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 30.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: isPortraitOrientation
                      ? double.infinity
                      : (context.width * 3 / 4) - 20,
                  child: PrayerTimesWidget()),
              SizedBox(
                height: 100, //same hight of button
                child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                        _pages.length,
                        (index) => HomeButton(
                            text: AppStrings.appBarTitles(
                                withTwoLines: true)[index],
                            index: index,
                            page: _pages[index],
                            image: AppStrings.translate(
                                "imagesOfHomePageButtons")[index]))),
              ),
              AdhkarGridView(crossAxisCount: isPortraitOrientation ? 2 : 4)
            ],
          ),
        ));
  }
}

List _pages = [
  BlocProvider(
      create: (context) => QuranCubit()..loadPdfFromAssets(),
      child: AlquranAlkarimPage()),
  SurahListPage(),
  ElecRosaryPage(),
  RamadanTabelPage(),
  QiblaPage(),
];
