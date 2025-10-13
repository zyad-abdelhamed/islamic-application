import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/features/app/presentation/controller/cubit/location_cubit.dart';
import 'package:test_app/core/widgets/save_or_update_location_widget.dart';
import 'package:test_app/features/app/presentation/view/components/erorr_widget.dart';
import 'package:test_app/core/services/internet_connection.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';

class SaveLocationButton extends StatelessWidget {
  const SaveLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<bool>>(
      future: Future.wait([
        sl<InternetConnection>().checkInternetConnection(),
        sl<BaseLocationService>().isServiceEnabled,
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AppLoadingWidget();
        }
        if (snapshot.hasError) {
          return const ErrorWidgetIslamic(
            message: "حدث خطاء حاول مرة اخرى لاحقا",
          );
        }
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final isConnected = snapshot.data![0];
        final isLocationEnabled = snapshot.data![1];

        return Padding(
          padding: const EdgeInsets.only(top: 8.0), // مسافة صغيرة قبل الزر
          child: BlocProvider<LocationCubit>(
            create: (context) => sl<LocationCubit>(),
            child: SaveOrUpdateLocationWidget(
              functionaltiy: Functionaltiy.save,
              buttonName: AppStrings.translate("saveLocation"),
              isConnected: isConnected,
              isLocationEnabled: isLocationEnabled,
            ),
          ),
        );
      },
    );
  }
}
