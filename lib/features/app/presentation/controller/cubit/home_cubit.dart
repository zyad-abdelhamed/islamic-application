import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/internet_connection.dart';
import 'package:test_app/features/app/domain/usecases/get_today_hadith_use_case.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this.getTodayHadithUseCase,
  ) : super(const HomeState());

  final GetTodayHadithUseCase getTodayHadithUseCase;
  
  void checkLocationPermission(BuildContext context) async {
    if (await sl<BaseLocatationService>().checkPermission ==
        LocationPermission.denied) {
      appSneakBar(
          context: context,
          message: 'تم رفض صلاحية الموقعتم رفض صلاحية الموقع',
          label: "صلاحية الموقع",
          onPressed: () async => await sl<BaseLocatationService>().requestPermission,
          isError: true);
    }
  }
  
  void checkInternetConnection(BuildContext context) async {
    if (await sl<InternetConnection>().checkInternetConnection()) {
      appSneakBar(
          context: context,
          message: "No internet connection",
          isError: true);
    }
  }
}


