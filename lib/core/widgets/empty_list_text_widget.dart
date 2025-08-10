import 'package:flutter/material.dart';
import 'package:test_app/core/theme/text_styles.dart';

class EmptyListTextWidget extends StatelessWidget {
  const EmptyListTextWidget({super.key, required this.text});
  
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyles.bold20(context),
                ),
              );
  }
}