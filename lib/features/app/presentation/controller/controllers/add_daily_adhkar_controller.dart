import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/services/image_picker_service.dart';
import 'package:test_app/core/widgets/app_sneak_bar.dart';
import 'package:test_app/features/app/domain/entities/daily_adhkar_entity.dart';
import 'package:test_app/features/app/presentation/controller/cubit/daily_adhkar_cubit.dart';

class AddDailyAdhkarController {
  late final TextEditingController textController;

  /// Notifiers
  late final ValueNotifier<File?> selectedImage;
  late final ValueNotifier<bool> isLoading;

  void initState() {
    textController = TextEditingController();
    selectedImage = ValueNotifier<File?>(null);
    isLoading = ValueNotifier<bool>(false);
  }

  void dispose() {
    textController.dispose();
    selectedImage.dispose();
    isLoading.dispose();
  }

  Future<void> pickImage(ImageSourceType sourceType) async {
    final picked =
        await sl<BaseImagePickerService>().pickImage(sourceType: sourceType);
    if (picked != null) {
      selectedImage.value = picked;
    }
  }

  void onAddPressed(BuildContext context) {
    if (selectedImage.value == null && textController.text.isEmpty) {
      AppSnackBar(
        message: "يجب ادخال نص او صورة",
        type: AppSnackBarType.error,
      ).show(context);
      return;
    }

    final text = textController.text.trim();
    final file = selectedImage.value;

    final entity = DailyAdhkarEntity(
      text: text.isEmpty ? null : text,
      image: file?.readAsBytesSync(),
      isShowed: false,
      createdAt: DateTime.now(),
    );

    DailyAdhkarCubit.get(context).addDailyAdhkar(entity);
  }
}
