import 'dart:io';
import 'package:dio/dio.dart';

abstract class IDownloadService {
  /// يحمل بيانات من رابط معين ويحفظها في ملف معين (تم إنشاؤه مسبقًا)
  Future<File> downloadToFile({
    required String url,
    required File targetFile,
  });
}

class DownloadServiceByDio implements IDownloadService {
  final Dio dio;

  const DownloadServiceByDio({required this.dio});

  @override
  Future<File> downloadToFile({
    required String url,
    required File targetFile,
  }) async {
    final response = await dio.download(
      url,
      targetFile.path,
      options: Options(responseType: ResponseType.bytes),
    );

    if (response.statusCode == 200) {
      return targetFile;
    } else {
      throw Exception('فشل تحميل الملف: $url');
    }
  }
}
