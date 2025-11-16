import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/core/widgets/custom_alert_dialog.dart';
import 'package:test_app/features/app/domain/entities/hifz_plan_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surahs_info_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/hifz_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/hifz_state.dart';
import 'package:test_app/features/app/presentation/view/components/quran_memorization_plan_tile.dart';
import 'package:test_app/features/app/presentation/view/pages/quran_memorization_plan_page.dart';

class QuranMemorizationPlansWidget extends StatelessWidget {
  const QuranMemorizationPlansWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HifzCubit, HifzState>(
      listener: (context, state) {
        if (state is HifzActionSuccess) {
          AppSnackBar(message: state.message, type: AppSnackBarType.success)
              .show(context);

          context.read<HifzCubit>().loadPlans();
        }

        if (state is HifzError) {
          AppSnackBar(message: state.message, type: AppSnackBarType.error)
              .show(context);
        }
      },
      buildWhen: (previous, current) =>
          current is HifzInitial ||
          current is HifzLoading ||
          current is HifzLoaded,
      builder: (context, state) {
        if (state is HifzLoaded) {
          final List<HifzPlanEntity> plans = state.plans;

          return ListView(
            padding: const EdgeInsets.all(8.0),
            physics: const BouncingScrollPhysics(),
            children: [
              // add button
              GestureDetector(
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => AddPlanDialog(
                    index: plans.length + 1,
                    existingPlans:
                        List.from(plans.map((e) => e.planName).toList()),
                  ),
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
                state.plans.length,
                (i) {
                  final HifzPlanEntity plan = state.plans[i];

                  return QuranMemorizationPlanTile(
                    title: plan.planName,
                    subtitle:
                        "${plan.lastProgress}\n\nتاريخ الانشاء: ${plan.createdAt}",
                    trailing: const Icon(
                      Icons.chevron_right,
                      size: 32,
                      color: Colors.grey,
                    ),
                    progress: 0.3,
                    onTap: () => _onTap(context, plan),
                  );
                },
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  void _onTap(BuildContext context, HifzPlanEntity hifzPlanEntity) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return BlocProvider<GetSurahsInfoCubit>(
        create: (context) => sl<GetSurahsInfoCubit>(),
        child: QuranMemorizationPlanPage(hifzPlanEntity: hifzPlanEntity),
      );
    }));
  }
}

class AddPlanDialog extends StatefulWidget {
  final int index;
  final List<String> existingPlans;

  const AddPlanDialog({
    super.key,
    required this.index,
    required this.existingPlans,
  });

  @override
  State<AddPlanDialog> createState() => _AddPlanDialogState();
}

class _AddPlanDialogState extends State<AddPlanDialog> {
  late final TextEditingController controller;
  late final FocusNode focusNode;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool backspacePressedOnce = false;

  @override
  void initState() {
    super.initState();
    final initialText = "خطة حفظ جديدة ${widget.index}";
    controller = TextEditingController(text: initialText)
      ..selection =
          TextSelection(baseOffset: 0, extentOffset: initialText.length);
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    if (formKey.currentState?.validate() ?? false) {
      context.read<HifzCubit>().addPlan(controller.text);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HifzCubit>(),
      child: CustomAlertDialog(
        title: AppStrings.translate("createNewPlan"),
        iconWidget: (_) => const Icon(
          Icons.add,
          size: 32,
          color: AppColors.secondryColor,
        ),
        alertDialogContent: (_) => Form(
          key: formKey,
          child: KeyboardListener(
            focusNode: focusNode,
            onKeyEvent: (KeyEvent event) {
              if (event is KeyDownEvent) {
                if (event.logicalKey == LogicalKeyboardKey.backspace) {
                  if (!backspacePressedOnce) {
                    controller.clear();
                    backspacePressedOnce = true;
                  }
                }

                if (event.logicalKey == LogicalKeyboardKey.enter ||
                    event.logicalKey == LogicalKeyboardKey.numpadEnter ||
                    event.logicalKey == LogicalKeyboardKey.execute) {
                  _submit();
                }
              }
            },
            child: TextFormField(
              controller: controller,
              autofocus: true,
              maxLength: 20,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
              onChanged: (_) => backspacePressedOnce = false,
              validator: (value) => _validator(value, widget.existingPlans),
            ),
          ),
        ),
      ),
    );
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
