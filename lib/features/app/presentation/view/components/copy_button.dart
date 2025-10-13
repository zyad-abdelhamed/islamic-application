import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/core/theme/app_colors.dart';

class CopyButton extends StatefulWidget {
  final String textToCopy;
  final Color color;

  const CopyButton({
    super.key,
    required this.textToCopy,
    this.color = Colors.grey,
  });

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> {
  bool isCopied = false;

  Future<void> _copy() async {
    setState(() {
      isCopied = true;
    });

    await Clipboard.setData(ClipboardData(text: widget.textToCopy));

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isCopied = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isCopied)
          const Text(
            "تم النسخ",
            style: TextStyle(color: AppColors.successColor, fontSize: 14),
          ),
        IconButton(
          onPressed: _copy,
          icon: Icon(
            Icons.copy,
            color: isCopied ? AppColors.successColor : widget.color,
          ),
        ),
      ],
    );
  }
}
