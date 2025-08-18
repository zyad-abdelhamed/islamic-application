import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/core/constants/app_strings.dart';
 class Failure extends Equatable {
  final String message;

  const Failure(this.message);
  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  factory ServerFailure.fromDiorError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure('انتهت مهلة الاتصال بخادم API');

      case DioExceptionType.sendTimeout:
        return const ServerFailure('انتهت مهلة إرسال الطلب إلى خادم API');

      case DioExceptionType.receiveTimeout:
        return const ServerFailure('انتهت مهلة استلام الرد من خادم API');

      case DioExceptionType.badCertificate:
        return const ServerFailure('شهادة الأمان غير صالحة من الخادم');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            e.response!.statusCode!, e.response!.data);

      case DioExceptionType.cancel:
        return const ServerFailure('تم إلغاء الطلب إلى خادم API');

      case DioExceptionType.connectionError:
        return const ServerFailure('لا يوجد اتصال بالإنترنت');

      case DioExceptionType.unknown:
        return ServerFailure(AppStrings.translate("unExpectedError"));
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 404) {
      return const ServerFailure('الطلب غير موجود، يرجى المحاولة لاحقاً');
    } else if (statusCode == 500) {
      return const ServerFailure('هناك مشكلة في الخادم، يرجى المحاولة لاحقاً');
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['message']);
    } else {
      return const ServerFailure('حدث خطأ، يرجى المحاولة مرة أخرى');
    }
  }
}
