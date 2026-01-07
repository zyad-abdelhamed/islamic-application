import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:vibration/vibration.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/utils/extentions/theme_extention.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/domain/entities/hifz_plan_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surahs_info_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/hifz_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/hifz_state.dart';
import 'package:test_app/features/app/presentation/view/components/quran_memorization_plan_tile.dart';
import 'package:test_app/features/app/presentation/view/pages/quran_memorization_plan_page.dart';
import 'package:test_app/core/services/dependency_injection.dart';

class QuranMemorizationPlansWidget extends StatelessWidget {
  const QuranMemorizationPlansWidget({
    super.key,
    required this.selectedPlans,
    required this.onSelectionChanged,
  });

  final List<String> selectedPlans;
  final VoidCallback onSelectionChanged;

  bool get isSelectionMode => selectedPlans.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final HifzCubit cubit = context.read<HifzCubit>();

    return BlocConsumer<HifzCubit, HifzState>(
      listener: (context, state) {
        if (state is HifzActionSuccess) {
          AppSnackBar(
            message: state.message,
            type: AppSnackBarType.success,
          ).show(context);

          cubit.loadPlans();
        }

        if (state is HifzError) {
          AppSnackBar(
            message: state.message,
            type: AppSnackBarType.error,
          ).show(context);
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
              /// ===== Add New Plan =====
              if (!isSelectionMode)
                GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => AddPlanDialog(
                      cubit: cubit,
                      index: plans.length + 1,
                      existingPlans: plans.map((e) => e.planName).toList(),
                    ),
                  ),
                  child: QuranMemorizationPlanTile(
                    title: AppStrings.translate("createNewPlan"),
                    leading: Container(
                      height: double.infinity,
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? Colors.grey.shade800
                            : Colors.grey.shade300,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.grey,
                      ),
                    ),
                    progress: 0.0,
                  ),
                ),

              /// ===== Existing Plans =====
              ...List.generate(plans.length, (i) {
                final plan = plans[i];
                final isSelected = selectedPlans.contains(plan.planName);

                return QuranMemorizationPlanTile(
                  title: plan.planName,
                  subtitle:
                      "${plan.lastProgress}\n\nتاريخ الانشاء: ${plan.createdAt}",
                  leading: isSelectionMode
                      ? Checkbox.adaptive(
                          value: isSelected,
                          activeColor: AppColors.primaryColor,
                          onChanged: (_) {
                            isSelected
                                ? selectedPlans.remove(plan.planName)
                                : selectedPlans.add(plan.planName);
                            onSelectionChanged.call();
                          },
                        )
                      : null,
                  trailing: const Icon(
                    Icons.chevron_right,
                    size: 32,
                    color: Colors.grey,
                  ),
                  progress: 0.3,
                  onTap: () {
                    if (isSelectionMode) {
                      isSelected
                          ? selectedPlans.remove(plan.planName)
                          : selectedPlans.add(plan.planName);
                      onSelectionChanged.call();
                    } else {
                      _onTap(context, plan);
                    }
                  },
                  onLongPress: selectedPlans.isNotEmpty
                      ? null
                      : () async {
                          if (await Vibration.hasVibrator()) {
                            Vibration.vibrate(duration: 30);
                          }
                          selectedPlans.add(plan.planName);
                          onSelectionChanged.call();
                        },
                );
              }),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  void _onTap(BuildContext context, HifzPlanEntity hifzPlanEntity) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider<GetSurahsInfoCubit>(
          create: (context) => sl<GetSurahsInfoCubit>(),
          child: QuranMemorizationPlanPage(
            hifzPlanEntity: hifzPlanEntity,
          ),
        ),
      ),
    );
  }
}

class AddPlanDialog extends StatefulWidget {
  final int index;
  final List<String> existingPlans;
  final HifzCubit cubit;

  const AddPlanDialog({
    super.key,
    required this.cubit,
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
    controller = TextEditingController(text: initialText);
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (formKey.currentState?.validate() ?? false) {
      Navigator.pop(context);
      widget.cubit.addPlan(controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.cubit,
      child: AlertDialog(
        title: Text(AppStrings.translate("createNewPlan")),
        content: Form(
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
