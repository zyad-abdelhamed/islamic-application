import 'package:flutter/material.dart';
import 'package:test_app/app/presentation/view/components/circle_avatar_button.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';

class SupplicationWidget extends StatelessWidget {
  final int index;
  final VoidCallback function;
  final List list;
  const SupplicationWidget({super.key, required this.index, required this.function, required this.list});

  @override
  Widget build(BuildContext context) {
    return Column(
                    spacing: 15.0,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: index != 0 ? 30.0 : 0.0, //space between items
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.grey1,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${list[index]['word']}",
                              style: TextStyles.bold20(context),
                            ),
                            Text(
                              "${list[index]['word']}",
                              style: TextStyles.regular16_120(context,
                                  color: AppColors.secondryColor),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: context.width / 5,
                              height: context.height / 20,
                              //100,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.grey2),
                              child: Text(
                                list[index]['num'].toString(),
                                key: ValueKey<int>(list[index]['num']),
                                style: TextStyles.bold20(context)
                                    .copyWith(fontSize: 25),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                          spacing: context.width * .10,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <GestureDetector>[
                            circleAvatarButton(
                              context: context,
                              icon: Icons.minimize_outlined,
                              function: function,
                            ),
                            circleAvatarButton(
                              context: context,
                              icon: Icons.loop,
                              function: () {},
                            )
                          ])]);
  }
}