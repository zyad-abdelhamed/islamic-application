import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surahs_info_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/quran_memorization_plan_tile.dart';
import 'package:test_app/features/app/presentation/view/pages/quran_memorization_plan_page.dart';

class QuranMemorizationPlansWidget extends StatelessWidget {
  const QuranMemorizationPlansWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      physics: const BouncingScrollPhysics(),
      children: [
        // add button
        GestureDetector(
          onTap: () => _showAddDialog(
            context,
            index: 1,
            existingPlans: [],
          ),
          child: QuranMemorizationPlanTile(
            title: AppStrings.translate("createNewPlan"),
            leading: Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(100),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.grey,
              ),
            ),
            progress: 0.0, // بدون خط تقدمي
          ),
        ),
        // data
        ...List.generate(
          2,
          (i) => QuranMemorizationPlanTile(
            title: "خطة حفظ ١",
            trailing: const Icon(
              Icons.chevron_right,
              size: 32,
              color: Colors.grey,
            ),
            progress: 0.3,
            onTap: () => _onTap(context),
          ),
        ),
      ],
    );
  }

  void _onTap(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return BlocProvider<GetSurahsInfoCubit>(
        create: (context) => sl<GetSurahsInfoCubit>(),
        child: QuranMemorizationPlanPage(),
      );
    }));
  }

  void _showAddDialog(BuildContext context,
      {required int index, required List<String> existingPlans}) async {
    final String initialText = "خطة حفظ جديدة $index";
    final TextEditingController controller =
        TextEditingController(text: initialText);
    final FocusNode focusNode = FocusNode();
    bool backspacePressedOnce = false;

    controller.selection =
        TextSelection(baseOffset: 0, extentOffset: initialText.length);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.translate("createNewPlan")),
        content: KeyboardListener(
          focusNode: focusNode,
          onKeyEvent: (KeyEvent event) {
            if (event.logicalKey == LogicalKeyboardKey.backspace &&
                event is KeyDownEvent) {
              if (!backspacePressedOnce) {
                controller.clear();
                backspacePressedOnce = true;
              }
            }
          },
          child: TextFormField(
            controller: controller,
            autofocus: true,
            onChanged: (_) => backspacePressedOnce = false,
            validator: (value) => _validator(value, existingPlans),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // ✅ هنا يتم حفظ الخطة الجديدة
              Navigator.pop(context);
            },
            child: const Text("حفظ"),
          ),
        ],
      ),
    );

    controller.dispose();
    focusNode.dispose();
  }

  String? _validator(String? value, List<String> existingPlans) {
    if (value == null || value.isEmpty) {
      return "الاسم لا يمكن أن يكون فارغًا";
    } else if (existingPlans.contains(value)) {
      return "الاسم مستخدم بالفعل";
    }

    return null;
  }
}
