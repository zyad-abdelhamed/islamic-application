import 'package:flutter/material.dart';
import 'package:test_app/app/presentation/view/components/parts_widget.dart';
import 'package:test_app/app/presentation/view/components/surahs_grid_view.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class IndexWidget extends StatelessWidget {
  const IndexWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: context.height * .70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           // PartsWidget(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SurahsGridView(),
              ),
            )
          ],
        ),
      ),
    );
  }
}