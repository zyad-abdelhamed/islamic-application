import 'package:flutter/material.dart';

class AyahNumberWidget extends StatelessWidget {
  final int number;

  const AyahNumberWidget({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40, // تقدر تتحكم في العرض
      height: 40, // وتتحكم في الطول
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/rub-el-hizb.png",
            fit: BoxFit.contain,
          ),
          Text(
            number.toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black, // يبان فوق الصورة
            ),
          ),
        ],
      ),
    );
  }
}
