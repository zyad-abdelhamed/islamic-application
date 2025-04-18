import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_app/features/app/presentation/controller/cubit/alert_dialog_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/elec_rosary_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/featured_records_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/rtabel_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/supplications_cubit.dart';
import 'package:test_app/core/theme/theme_provider.dart';

extension ResponsiveExtention on BuildContext {
  ElecRosaryCubit get elecRosaryController =>
      ElecRosaryCubit.getElecRosaryController(this);
  ThemeProvider get themeController => Provider.of<ThemeProvider>(this);
  AlertDialogCubit get alertDialogController =>
      BlocProvider.of<AlertDialogCubit>(this);

  SupplicationsCubit get supplicationsController =>
      BlocProvider.of<SupplicationsCubit>(this);

  RtabelCubit get ramadanTableController =>
      RtabelCubit.getRamadanTableController(this);

  FeaturedRecordsCubit get featuerdRecordsController =>
      FeaturedRecordsCubit.getFeatuerdRecordsController(this);
}
