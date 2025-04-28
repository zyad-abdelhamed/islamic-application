import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_durations.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/presentation/controller/cubit/home_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_custom_grid_view.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_buttons_row.dart';
import 'package:test_app/features/app/presentation/view/components/home_page_drawer.dart';
import 'package:test_app/features/app/presentation/view/components/prayer_times_widget.dart';

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
                        HomePageButtonsRow(),
                        AdhkarCustomGridView(crossAxisCount: 4)
                      ],
                    ),
                  ),
                              ),
                            )),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return AnimatedOpacity(duration:AppDurations.longDuration,opacity: state.opacity,
                                  child: Visibility(visible: state.isVisible,
                                    child: GestureDetector(                                                onTap: homeCubit.hideDawerInCaseLandScape,
                                                        
                                      child: Container(color: Colors.grey.withValues(alpha: .5),height: double.infinity,width: double.infinity)),
                                  ));
                  },
                )],
              ))
        ],
      ),
    );
  }
}
