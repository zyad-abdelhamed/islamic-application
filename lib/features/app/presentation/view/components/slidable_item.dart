import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/features/app/domain/entities/surah_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surahs_info_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/show_downloading_dialog.dart';
import 'package:test_app/features/app/presentation/view/components/surah_item.dart';
import 'package:test_app/features/app/presentation/view/pages/surahs_page.dart';

class SlidableItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final bool isDownloaded = surah.isDownloaded;

    return Slidable(
      key: ObjectKey(surah), // عشان يفرق بين العناصر

      // السحب للشمال
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (context) async {
              final bool? changed = await showDownloadDialog(
                context: context,
                surah: surah,
                surahNumber: surahNumber,
              );

              if (changed ?? false) {
                if (context.mounted) {
                  _rebuild(context);
                }
              }
            },
            icon: isDownloaded
                ? CupertinoIcons.delete
                : Icons.download_for_offline,
            backgroundColor: Colors.transparent,
            foregroundColor:
                isDownloaded ? AppColors.errorColor : Colors.lightBlueAccent,
          ),
        ],
      ),

      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SurahItem(
            surah: surah,
            textColor: textColor,
            cardColor: Colors.transparent,
            borderColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade800
                : Colors.grey.shade300,
          ),
          if (showSaveIcon)
            Positioned(
              right: -4,
              top: -4,
              child: isDownloaded
                  ? const DownloadedMark()
                  : const SizedBox.shrink(), // لو مش متحمل نخفيها
            ),
        ],
      ),
    );
  }

  void _rebuild(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider<GetSurahsInfoCubit>(
            create: (_) => sl<GetSurahsInfoCubit>(),
            child: const SurahListPage(),
          ),
        ));
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
