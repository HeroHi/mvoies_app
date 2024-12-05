import 'package:dio/dio.dart';
import 'package:movies_app/core/networking/api_error_model.dart';

class ApiErrorHandler {
  static const String _defaultErrorMsg =
      "Something went wrong, please try again later";
  static ApiErrorModel handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(message: "Connection to server timeout.");
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(message: "Send to server timeout");
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(message: "Receive from server timeout");
        case DioExceptionType.badCertificate:
          return ApiErrorModel(message: "bad Certificate");
        case DioExceptionType.badResponse:
          return _handleErrorResponse(error.response!.data);
        case DioExceptionType.cancel:
          return ApiErrorModel(message: "Connection to the server canceled");
        case DioExceptionType.connectionError:
          return ApiErrorModel(message: "Could not connect to server");
        case DioExceptionType.unknown:
          ApiErrorModel(message: _defaultErrorMsg);
      }
    }
    return ApiErrorModel(message: _defaultErrorMsg);
  }

  static ApiErrorModel _handleErrorResponse(response) {
    return ApiErrorModel(
        message: response['message'] ?? _defaultErrorMsg,
        code: response['code'],
        success: response['success']);
  }
}
