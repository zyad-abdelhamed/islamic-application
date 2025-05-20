import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/presentation/controller/cubit/home_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_button.dart';
import 'package:test_app/features/app/presentation/view/components/home_button.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_drawer.dart';
import 'package:test_app/features/app/presentation/view/components/prayer_times_widget.dart';
import 'package:test_app/features/app/presentation/view/pages/adhkar_page.dart';

class LandScapeToHomePage extends StatelessWidget {
  const LandScapeToHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeCubit homeCubit = context.read<HomeCubit>();
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Center(
                    child: IconButton(
                        onPressed: () {
                          homeCubit.showDawerInCaseLandScape(context);
                        },
                        icon: Icon(Icons.menu, color: AppColors.grey)),
                  ),
                  AnimatedContainer(
                    duration: AppDurations.longDuration,
                    width: state.width,
                    height: double.infinity,
                    child: ColoredBox(
                        color: AppColors.primaryColor,
                        child: SafeArea(child: HomeDrawerWidget())),
                  ),
                ],
              );
            },
          ),
          Expanded(
              child: Stack(
            children: [
              SingleChildScrollView(
                  child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: homeCubit.hideDawerInCaseLandScape,
                    child: Column(
                      spacing: 30.0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: (context.width * 3 / 4) - 20,
                            child: PrayerTimesWidget()),
                        SizedBox(
                          height: 100, //same hight of button
                          child: ListView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                  AppStrings.pages.length,
                                  (index) => HomeButton(
                                      text: AppStrings.appBarTitles(
                                          withTwoLines: true)[index],
                                      index: index,
                                      page: AppStrings.pages[index],
                                      image: AppStrings
                                          .imagesOfHomePageButtons[index]))),
                        ),
                        GridView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 15),
                            children: List<AdhkarButton>.generate(
                                8,
                                (index) => AdhkarButton(
                                      icon: AppStrings.supplicationIcons[index],
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AdhkarPage(
                                                  nameOfAdhkar: AppStrings
                                                          .supplicationsButtonsNames[
                                                      index]),
                                            ));
                                      },
                                      text: AppStrings
                                          .supplicationsButtonsNames[index],
                                    )))
                      ],
                    ),
                  ),
                ),
              )),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return AnimatedOpacity(
                      duration: AppDurations.longDuration,
                      opacity: state.opacity,
                      child: Visibility(
                        visible: state.isVisible,
                        child: GestureDetector(
                            onTap: homeCubit.hideDawerInCaseLandScape,
                            child: Container(
                                color: Colors.grey.withValues(alpha: .5),
                                height: double.infinity,
                                width: double.infinity)),
                      ));
                },
              )
            ],
          ))
        ],
      ),
    );
  }
}
