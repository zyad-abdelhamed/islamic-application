import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/core/utils/responsive_extention.dart';
import 'package:test_app/features/app/domain/entities/reciters_entity.dart';

class ReciterCardWidget extends StatelessWidget {
  final ReciterEntity reciter;
  final Function() onPressed;
  const ReciterCardWidget({
    super.key,
    required this.reciter,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final cardPadding = context.width * 0.04;
    final imageRadius = context.width * 0.11;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: cardPadding * 0.6,
        horizontal: cardPadding,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Card(
              elevation: 6,
              color: AppColors.lightModePrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  left: cardPadding,
                  right: imageRadius * 2.2,
                  top: cardPadding * 0.8,
                  bottom: cardPadding * 0.8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // اسم القارئ
                        Text(reciter.name,
                            style: TextStyles.semiBold20(
                              context,
                            )),
                        SizedBox(height: context.height * 0.007),

                        // اللغة
                        Text("اللغة: ${reciter.language}",
                            style: TextStyles.semiBold16(
                                context: context,
                                color: AppColors.darkModeTextColor)),
                        SizedBox(height: context.height * 0.015),
                      ],
                    ),
                    IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        Icons.download_rounded,
                        color: Colors.white,
                        size: context.width * 0.07,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: -imageRadius * 0.3,
            top: -imageRadius * 0.5,
            bottom: -imageRadius * 0.5,
            child: CircleAvatar(
              radius: imageRadius,
              backgroundColor: Colors.grey.shade800,
              backgroundImage: AssetImage(reciter.image),
            ),
          ),
        ],
      ),
    );
  }
}
