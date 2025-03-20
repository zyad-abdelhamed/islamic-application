import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';

class CheckBoxsWidget extends StatelessWidget {
  const CheckBoxsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
                                        builder: (context, Constraints) {
                                      return Wrap(
                                          children: List.generate(
                                              16 * 30,
                                              (index) => Container(decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey1)),
                                                width:
                                                    Constraints.maxWidth /
                                                        16,
                                                height:
                                                    50, //50 for hight (blue container)
                                                child: Center(
                                                  child: Checkbox(
                                                    value: false,
                                                    onChanged: (value) {},
                                                  ),
                                                ),
                                              )));
                                    });
                                    //   GridView.builder(
                                    //    gridDelegate:
                                    //        const SliverGridDelegateWithFixedCrossAxisCount(
                                    //            crossAxisCount: 16,mainAxisSpacing: 4),
                                    //    itemCount: 16 * 30,
                                    //    itemBuilder: (context, index) {
                                    //      return Checkbox(activeColor: Colors.greenAccent,
                                    //        value:false,onChanged: (value) {

                                    //        },
                                    //      //    controller.cb_values?[index]??false,
                                    //      //   onChanged:(value) {
                                    //      //   controller. cb_values![index] = value??false ;
                                    //      // controller.  savecheckboxvalue(index, value);
                                    //      //  controller.f();
                                    //      //   },

                                    //      );
                                    //    },
                                    //  );
  }
}