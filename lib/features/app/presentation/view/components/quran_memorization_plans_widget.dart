import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/domain/entities/hifz_plan_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/get_surahs_info_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/hifz_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/hifz_state.dart';
import 'package:test_app/features/app/presentation/view/components/quran_memorization_plan_tile.dart';
import 'package:test_app/features/app/presentation/view/pages/quran_memorization_plan_page.dart';
import 'package:test_app/core/services/dependency_injection.dart';

class QuranMemorizationPlansWidget extends StatelessWidget {
  const QuranMemorizationPlansWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HifzCubit, HifzState>(
      listener: (context, state) {
        if (state is HifzActionSuccess) {
          AppSnackBar(
            message: state.message,
            type: AppSnackBarType.success,
          ).show(context);

          context.read<HifzCubit>().loadPlans();
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
              GestureDetector(
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => AddPlanDialog(
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
                      color: Colors.grey.withAlpha(100),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
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
          child: QuranMemorizationPlanPage(hifzPlanEntity: hifzPlanEntity),
        ),
      ),
    );
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final initialText = "خطة حفظ جديدة ${widget.index}";
    controller = TextEditingController(text: initialText);
  }

  @override
  void dispose() {
    controller.dispose();
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
    return BlocProvider.value(
      value: context.read<HifzCubit>(),
      child: AlertDialog(
        title: Row(
          children: [
            const Icon(
              Icons.add,
              color: AppColors.secondryColor,
            ),
            const SizedBox(width: 8),
            Text(AppStrings.translate("createNewPlan")),
          ],
        ),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            autofocus: true,
            maxLength: 20,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            validator: (value) => _validator(value, widget.existingPlans),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("إلغاء"),
          ),
          ElevatedButton(
            onPressed: _submit,
            child: const Text("حفظ"),
          ),
        ],
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
