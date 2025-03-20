import 'package:flutter/material.dart';
import 'package:test_app/app/presentation/view/components/check_boxs_widget.dart';
import 'package:test_app/app/presentation/view/components/ramadan_calendar_widget.dart';
import 'package:test_app/app/presentation/view/components/ramadan_table_column.dart';
import 'package:test_app/core/constants/view_constants.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
class LandScapeWidgetToRTablePage extends StatelessWidget {
  const LandScapeWidgetToRTablePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                     decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(
                                            color: AppColors.purple)),
                      color: AppColors.secondryColor),
                      child: Center(
                          child: FittedBox(
                        child: Text('اليوم',
                            style: TextStyles.semiBold20(context).copyWith(color: AppColors.purple)),
                      ))),
                ),
                Expanded(
                  flex: 16,
                  child: LayoutBuilder(
                    builder: (context, constraints) => Row(
                      children: [
                        Flexible(
                          flex: 9,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.grey1)),
                                    child: const Center(
                                        child: Text('الصلاة'))),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: RamadanTableColumn(
                                        width:
                                            constraints.maxWidth /
                                                16,
                                        title: 'الفروض',
                                        listOfStrings: ViewConstants
                                            .namesOfPrayers,
                                        count: 5,
                                      ),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: RamadanTableColumn(
                                          width:
                                              constraints.maxWidth /
                                                  16,
                                          title: 'النوافل',
                                          listOfStrings: ViewConstants
                                              .namesOfVoluntaryPrayers,
                                          count: 4,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: RamadanTableColumn(
                              width: constraints.maxWidth / 16,
                              title: 'ألاذكار',
                              listOfStrings:
                                  ViewConstants.supplications,
                              count: 5),
                        ),
                        Flexible(
                          flex: 2,
                          child: RamadanTableColumn(
                              width: constraints.maxWidth / 16,
                              title: 'قران',
                              listOfStrings: ViewConstants.list,
                              count: 2),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(flex: 2,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 2, child: RamadanCalendarWidget()),
                    Expanded(flex: 16, child: CheckBoxsWidget())
                  ]),
            ),
          )
        ],
      ),
    );
  }
}

