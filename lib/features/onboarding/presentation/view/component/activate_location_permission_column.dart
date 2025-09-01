import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/position_service.dart';
import 'package:test_app/core/theme/text_styles.dart';

List<Widget> activateLocationPermissionColumn(BuildContext context) {
  return <Widget>[
    Icon(Icons.location_on, size: 100, color: Theme.of(context).primaryColor),
    SizedBox(height: 20),
    Text(
      AppStrings.translate("activationLocationRequired"),
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
    const SizedBox(height: 12),
    Text(
      AppStrings.translate("usesOfActivationLocation"),
      style: TextStyles.semiBold16_120(context),
      textAlign: TextAlign.center,
    ),
    const SizedBox(height: 30),
    ElevatedButton(
      onPressed: () async =>
          await sl<BaseLocationService>().requestPermission(),
      child: Text(AppStrings.translate("activationLocationNow")),
    ),
  ];
}
