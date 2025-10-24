import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/features/app/presentation/controller/cubit/speech_cubit.dart';
import 'package:test_app/features/app/presentation/view/pages/speech_page.dart';

class QuranHifzPage extends StatefulWidget {
  const QuranHifzPage({super.key});

  @override
  State<QuranHifzPage> createState() => _QuranHifzPageState();
}

class _QuranHifzPageState extends State<QuranHifzPage> {
  final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("تحفيظ القرآن"),
          leading: const GetAdaptiveBackButtonWidget(
              backBehavior: BackBehavior.pop)),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) => currentIndex.value = index,
        children: [
          BlocProvider(
            create: (context) => SpeechCubit(),
            child: SpeechPage(),
          ),
          Center(child: Text('الخطط')),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: currentIndex,
        builder: (context, index, _) {
          return BottomNavigationBar(
            selectedItemColor: Theme.of(context).primaryColor,
            currentIndex: index,
            onTap: (i) {
              currentIndex.value = i;
              pageController.jumpToPage(i);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.mic),
                label: "تسميع",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: "الخطط",
              ),
            ],
          );
        },
      ),
    );
  }
}
