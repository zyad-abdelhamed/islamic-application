import 'package:flutter/material.dart';
import 'package:test_app/features/onboarding/presentation/view/component/save_location_button.dart';

class SaveLocationPage extends StatelessWidget {
  const SaveLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SaveLocationButton(),
        ],
      ),
    );
  }
}
