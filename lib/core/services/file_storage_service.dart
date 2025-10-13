import 'dart:io';
import 'package:path_provider/path_provider.dart';

abstract class IFileStorageService {
  Future<Directory> createFolder({required String folderName});
  Future<void> deleteFolder({required String folderName});
  Future<File> getFile({
    required String folderName,
    required String fileName,
    required String extension,
  });
}

class FileStorageServiceByPathProvider implements IFileStorageService {
  @override
  Future<Directory> createFolder({required String folderName}) async {
    try {
      final Directory baseDir = await getApplicationDocumentsDirectory();
      final Directory targetDir = Directory('${baseDir.path}/$folderName');

      if (!await targetDir.exists()) {
        await targetDir.create(recursive: true);
      }

      return targetDir;
    } catch (e) {
      throw Exception('فشل في إنشاء المجلد "$folderName": $e');
    }
  }

  @override
  Future<void> deleteFolder({required String folderName}) async {
    try {
      final Directory baseDir = await getApplicationDocumentsDirectory();
      final Directory targetDir = Directory('${baseDir.path}/$folderName');

      if (await targetDir.exists()) {
        await targetDir.delete(recursive: true);
      }
    } catch (e) {
      throw Exception('فشل في حذف المجلد "$folderName": $e');
    }
  }

  @override
  Future<File> getFile({
    required String folderName,
    required String fileName,
    required String extension,
  }) async {
    try {
      final Directory baseDir = await getApplicationDocumentsDirectory();
      final String filePath =
          '${baseDir.path}/$folderName/$fileName.$extension';
      return File(filePath);
    } catch (e) {
      throw Exception(
          'فشل في الوصول إلى الملف "$fileName.$extension" داخل "$folderName": $e');
    }
  }
}
