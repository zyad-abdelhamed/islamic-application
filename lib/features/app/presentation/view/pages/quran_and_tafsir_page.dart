import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/theme/text_styles.dart';
import 'package:test_app/features/app/presentation/controller/cubit/tafsir_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/tafsir_state.dart';
import 'package:test_app/features/app/presentation/view/components/custom_top_bar.dart';
import 'package:test_app/features/app/presentation/view/components/expandable_tafsir_card.dart';
import 'package:test_app/features/app/presentation/view/components/quran_text_view.dart';

class QuranAndTafsirPage extends StatefulWidget {
  const QuranAndTafsirPage({super.key});

  @override
  State<QuranAndTafsirPage> createState() => _QuranAndTafsirPageState();
}

class _QuranAndTafsirPageState extends State<QuranAndTafsirPage> {
  final ValueNotifier<bool> isShowed = ValueNotifier<bool>(false);
  final ValueNotifier<int?> selectedAyah = ValueNotifier<int?>(null);

  final List<Map<String, dynamic>> ayat = [
    {
      "text": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
      "num": 1,
      "sajda": false
    },
    {"text": "الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ", "num": 2, "sajda": false},
    {"text": "الرَّحْمَٰنِ الرَّحِيمِ", "num": 3, "sajda": false},
    {
      "text": "وَإِذَا قُرِئَ عَلَيْهِمُ الْقُرْآنُ لَا يَسْجُدُونَ",
      "num": 4,
      "sajda": true
    },
  ];

  void showTafsir(int ayahNum) {
    selectedAyah.value = ayahNum;

    final ayahText =
        ayat.firstWhere((a) => a['num'] == ayahNum)['text'] as String;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                        context, RoutesConstants.editTafsirPage),
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Theme.of(context).primaryColor),
                        const SizedBox(width: 6),
                        Text(
                          'تحرير',
                          style: TextStyles.semiBold18(
                            context,
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "﴿ $ayahText ﴾",
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Amiri',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Divider(color: Theme.of(context).primaryColor),
                  BlocProvider(
                    create: (context) => TafsirEditCubit()..loadTafsir(),
                    child: BlocBuilder<TafsirEditCubit, TafsirEditState>(
                      builder: (context, state) {
                        return ListView.builder(
                          controller: scrollController,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.selected.length,
                          itemBuilder: (context, index) {
                            final tafsirText =
                                'هذا نص التفسير رقم $index ... ' * 10;

                            return ExpandableTafsirCard(
                                title: state.selected[index],
                                tafsirText: tafsirText,
                                color: Theme.of(context).primaryColor);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      selectedAyah.value = null;
    });
  }

  @override
  void dispose() {
    isShowed.dispose();
    super.dispose();
  }

  void _toggleTopBar() => isShowed.value = !isShowed.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ✅ عرض الآيات
          Positioned.fill(
            child: QuranTextView(
              ayat: ayat,
              onLongPress: showTafsir,
              selectedAyah: selectedAyah,
            ),
          ),

          // ✅ Overlay جديد ب GestureDetector
          Positioned.fill(
            child: GestureDetector(
              behavior:
                  HitTestBehavior.translucent, // يسمح بمرور longPress للي تحت
              onTap: _toggleTopBar, // toggle للتوب بار
              child: const SizedBox.expand(), // يملأ الشاشة كلها
            ),
          ),

          // ✅ التوب بار
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<bool>(
              valueListenable: isShowed,
              builder: (context, value, child) {
                return Visibility(
                  visible: value,
                  child: const CustomTopBar(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
