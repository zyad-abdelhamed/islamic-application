import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/constants/app_strings.dart';
import 'package:test_app/core/constants/routes_constants.dart';
import 'package:test_app/core/services/image_picker_service.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/widgets/app_functionalty_button.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/core/widgets/custom_scaffold.dart';
import 'package:test_app/features/app/presentation/controller/controllers/add_daily_adhkar_controller.dart';
import 'package:test_app/features/app/presentation/controller/cubit/daily_adhkar_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/daily_adhkar_state.dart';

class AddDailyAdhkarPage extends StatefulWidget {
  const AddDailyAdhkarPage({super.key});

  @override
  State<AddDailyAdhkarPage> createState() => _AddDailyAdhkarPageState();
}

class _AddDailyAdhkarPageState extends State<AddDailyAdhkarPage> {
  late final AddDailyAdhkarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AddDailyAdhkarController();
    _controller.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _controller.isLoading,
        child: CustomScaffold(
          appBar: AppBar(
            leading: const GetAdaptiveBackButtonWidget(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 16,
              children: [
                TextField(
                  controller: _controller.textController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: AppStrings.translate("dailyAdhkarFieldHint"),
                  ),
                ),

                /// عرض الصورة المختارة
                Expanded(
                  child: ValueListenableBuilder<File?>(
                    valueListenable: _controller.selectedImage,
                    builder: (context, file, _) {
                      if (file != null) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            file,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.grey2,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text("لم يتم اختيار صورة"),
                        ),
                      );
                    },
                  ),
                ),

                /// زرارين لاختيار الصورة
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () =>
                            _controller.pickImage(ImageSourceType.gallery),
                        icon: const Icon(Icons.photo_library),
                        label: const Text("معرض"),
                      ),
                    ),
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () =>
                            _controller.pickImage(ImageSourceType.camera),
                        icon: const Icon(Icons.camera_alt),
                        label: const Text("كاميرا"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocListener<DailyAdhkarCubit, DailyAdhkarState>(
              listener: (context, state) {
                if (state is DailyAdhkarAdding) {
                  _controller.isLoading.value = true;
                }
                if (state is DailyAdhkarAddSuccess) {
                  Navigator.pushReplacementNamed(
                    context,
                    RoutesConstants.homePageRouteName,
                  );
                }
                if (state is DailyAdhkarError) {
                  _controller.isLoading.value = false;

                  AppSnackBar(
                    message: state.message,
                    type: AppSnackBarType.error,
                  ).show(context);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child:
                    AppFunctionaltyButton<DailyAdhkarCubit, DailyAdhkarState>(
                  buttonName: "اضافة",
                  onPressed: () => _controller.onAddPressed(context),
                  isLoading: (state) => state is DailyAdhkarAdding,
                ),
              ),
            ),
          ),
        ),
        builder: (BuildContext context, bool value, Widget? scaffold) {
          return AbsorbPointer(
            absorbing: value,
            child: scaffold,
          );
        });
  }
}
