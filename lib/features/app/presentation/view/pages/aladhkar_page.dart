import 'package:flutter/material.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/utils/extentions/media_query_extention.dart';
import 'package:test_app/core/widgets/custom_scaffold.dart';
import 'package:test_app/features/app/presentation/view/components/adhkar_grid_view.dart';

class AlAdhkarPage extends StatelessWidget {
  const AlAdhkarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        leading: const GetAdaptiveBackButtonWidget(),
        title: Text(AppStrings.appBarTitles(withTwoLines: false)[3]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AdhkarGridView(
          crossAxisCount: context.isPotrait ? 2 : 4,
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
