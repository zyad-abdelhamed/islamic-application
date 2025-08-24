import 'dart:io';
import 'package:image_picker/image_picker.dart';

abstract class BaseImagePickerService {
  Future<File?> pickImage({required ImageSourceType sourceType});
}

enum ImageSourceType { camera, gallery }

class ImagePickerService implements BaseImagePickerService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<File?> pickImage({required ImageSourceType sourceType}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: sourceType == ImageSourceType.gallery
            ? ImageSource.gallery
            : ImageSource.camera,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
