import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton extends StatefulWidget {
  final String textToCopy;
  final Color color;

  const CopyButton({
    super.key,
    required this.textToCopy,
    required this.color,
  });

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> {
  final ValueNotifier<bool> isCopied = ValueNotifier(false);

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.textToCopy));
    isCopied.value = true;

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) isCopied.value = false;
    });
  }

  @override
  void dispose() {
    isCopied.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isCopied,
      builder: (context, copied, _) {
        return Row(
          children: [
            if (copied)
              const Text(
                "تم النسخ",
                style: TextStyle(color: Colors.green, fontSize: 14),
              ),
            IconButton(
              onPressed: _copy,
              icon: Icon(
                Icons.copy,
                color: copied ? Colors.green : widget.color,
              ),
            ),
          ],
        );
      },
    );
  }
}
