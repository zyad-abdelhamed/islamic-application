import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/presentation/controller/controllers/prayer_times_page_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_prayer_times_of_month_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/prayers_sound_settings_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/change_location_widget.dart';
import 'package:test_app/features/app/presentation/view/components/get_prayer_times_of_month_button.dart';
import 'package:test_app/features/app/presentation/view/components/prayer_times_of_month_widget.dart';
import 'package:test_app/features/app/presentation/view/components/prayer_times_page_app_bar.dart';
import 'package:test_app/features/app/presentation/view/components/prayers_sound_settings_bloc_consumer.dart';

class PrayerTimesPage extends StatefulWidget {
  const PrayerTimesPage({super.key});

  @override
  State<PrayerTimesPage> createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage> {
  late final PrayerTimesPageController prayerTimesPageController;
  late final PrayerSoundSettingsCubit prayerSoundSettingsCubit;
  @override
  void initState() {
    prayerTimesPageController = PrayerTimesPageController();
    prayerSoundSettingsCubit = context.read<PrayerSoundSettingsCubit>();
    prayerTimesPageController.initState(context);
    prayerSoundSettingsCubit.loadSettings();
    super.initState();
  }

  @override
  void dispose() {
    prayerTimesPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesConstants.homePageRouteName,
          (route) => false,
        );
        return false;
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: prayerTimesPageController.loadingNotifier,
        child: Scaffold(
          appBar: PrayerTimesPageAppBar(
            prayerSoundSettingsCubit: prayerSoundSettingsCubit,
            prayerTimesPageController: prayerTimesPageController,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ChangeLocationWidget(
                    prayerTimesPageController: prayerTimesPageController),
                const SizedBox(height: 50),
                PrayersSoundsSettingsBlocConsumer(
                  controller: prayerTimesPageController,
                ),
                const SizedBox(height: 30),
                BlocProvider(
                  create: (_) => sl<GetPrayerTimesOfMonthCubit>(),
                  child: Column(
                    spacing: 30,
                    children: [
                      GetPrayerTimesOfMonthButton(
                        prayerTimesPageController: prayerTimesPageController,
                      ),
                      SizedBox(
                        height: (context.height * .50) - 50,
                        child: PrayerTimesOfMonthWidget(
                            prayerTimesPageController:
                                prayerTimesPageController),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        builder: (_, bool isLoading, Widget? scaffold) => ModalProgressHUD(
          inAsyncCall: isLoading,
          progressIndicator: const GetAdaptiveLoadingWidget(),
          opacity: .5,
          child: scaffold!,
        ),
      ),
    );
  }
}
