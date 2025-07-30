import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/theme/text_styles.dart';

// ignore: must_be_immutable
class DuaaDisplay extends StatefulWidget {
  DuaaDisplay({super.key, required this.duaaTitle, required this.duaaBody});
  final String duaaTitle;
  final String duaaBody;
  bool visibility = false;

  @override
  State<DuaaDisplay> createState() => _DuaaDisplayState();
}

class _DuaaDisplayState extends State<DuaaDisplay>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Column(
        children: [
          // العنوان والسهم
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.duaaTitle,
                style: TextStyles.semiBold16(
                    context: context, color: AppColors.white),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.visibility = !widget.visibility;
                  });
                },
                icon: Icon(
                  widget.visibility
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down_sharp,
                  size: 30,
                ),
              )
            ],
          ),

          AnimatedSize(
            duration: const Duration(milliseconds: 600),
            curve: Curves.fastOutSlowIn,
            child: AnimatedOpacity(
              opacity: widget.visibility ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 600),
              child: widget.visibility
                  ? Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.secondryColor, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        widget.duaaBody,
                        style: TextStyles.regular14_150(
                          context,
                        ).copyWith(color: AppColors.white),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          )
        ],
      ),
    );
  }
}
