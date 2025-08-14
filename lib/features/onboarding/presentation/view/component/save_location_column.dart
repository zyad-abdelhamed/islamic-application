import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/theme/theme_provider.dart';
import 'package:test_app/features/app/presentation/controller/cubit/location_cubit.dart';
import 'package:test_app/core/widgets/save_or_update_location_widget.dart';
import 'package:test_app/features/app/presentation/view/components/erorr_widget.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/services/internet_connection.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';

List<Widget> saveLocationColumn(BuildContext context) {
  return <Widget>[
    // العنوان
    Text(
      "• خطوة أخرى",
      style: TextStyles.semiBold32(
        context,
        color: ThemeCubit.controller(context).state
            ? AppColors.darkModeTextColor
            : AppColors.lightModePrimaryColor,
      ),
    ),

    const SizedBox(height: 12), // مسافة أكبر تحت العنوان

    // النص التوضيحي
    Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        AppStrings.translate("saveLocationHintText"),
        style: TextStyles.semiBold16_120(context).copyWith(
          color: AppColors.secondryColor,
          fontFamily: "DataFontFamily",
          height: 1.5, // تحسين تباعد الأسطر
        ),
      ),
    ),

    // الفيوتشر بيلدر
    FutureBuilder<List<bool>>(
      future: Future.wait([
        sl<InternetConnection>().checkInternetConnection(),
        sl<BaseLocationService>().isServiceEnabled,
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const GetAdaptiveLoadingWidget();
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
    ),
  ];
}
