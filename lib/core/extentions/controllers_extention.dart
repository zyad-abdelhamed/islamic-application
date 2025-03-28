import 'package:flutter/material.dart';
import 'package:test_app/app/presentation/controller/cubit/elec_rosary_cubit.dart';
import 'package:test_app/app/presentation/controller/cubit/rtabel_cubit.dart';
import 'package:test_app/app/presentation/controller/cubit/supplications_cubit.dart';

extension ResponsiveExtention on BuildContext {
  ElecRosaryCubit get elecRosaryController =>
      ElecRosaryCubit.getAuthController(this);

  SupplicationsCubit get supplicationsController =>
      SupplicationsCubit.getSupplicationsController(this);

  RtabelCubit get ramadanTableController =>
      RtabelCubit.getRamadanTableController(this);
}
