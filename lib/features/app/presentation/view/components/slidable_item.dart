import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/presentation/view/components/show_downloading_dialog.dart';
import 'package:test_app/features/app/presentation/view/components/surah_item.dart';

class SlidableItem extends StatefulWidget {
  const SlidableItem({
    super.key,
    required this.surah,
    required this.surahNumber,
    required this.textColor,
    required this.showSaveIcon,
  });

  final SurahEntity surah;
  final int surahNumber;
  final Color textColor;
  final bool showSaveIcon;

  @override
  State<SlidableItem> createState() => _SlidableItemState();
}

class _SlidableItemState extends State<SlidableItem> {
  late final ValueNotifier<bool> isDownloadedNotifier;

  @override
  void initState() {
    super.initState();
    isDownloadedNotifier = ValueNotifier<bool>(widget.surah.isDownloaded);
  }

  @override
  void dispose() {
    isDownloadedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ObjectKey(widget.surah), // عشان يفرق بين العناصر

      // السحب للشمال
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          ValueListenableBuilder<bool>(
              valueListenable: isDownloadedNotifier,
              builder: (_, bool value, __) {
                return SlidableAction(
                  onPressed: (context) async {
                    final bool? changed = await showDownloadDialog(
                      context: context,
                      surah: widget.surah,
                      surahNumber: widget.surahNumber,
                    );

                    if (changed ?? false) {
                      isDownloadedNotifier.value = !isDownloadedNotifier.value;
                    }
                  },
                  icon: value
                      ? CupertinoIcons.delete
                      : Icons.download_for_offline,
                  backgroundColor: Colors.transparent,
                  foregroundColor:
                      value ? AppColors.errorColor : Colors.lightBlueAccent,
                );
              }),
        ],
      ),

      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SurahItem(
            surah: widget.surah,
            textColor: widget.textColor,
            cardColor: Colors.transparent,
            borderColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade800
                : Colors.grey.shade300,
          ),
          if (widget.showSaveIcon)
            Positioned(
              right: -4,
              top: -4,
              child: ValueListenableBuilder<bool>(
                valueListenable: isDownloadedNotifier,
                builder: (_, bool value, __) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutBack,
                        ),
                        child: child,
                      );
                    },
                    child: value
                        ? const DownloadedMark()
                        : const SizedBox.shrink(), // لو مش متحمل نخفيها
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class DownloadedMark extends StatelessWidget {
  const DownloadedMark({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: AppColors.successColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check,
        size: 14,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
      ),
    );
  }
}
