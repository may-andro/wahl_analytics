import 'package:dio/dio.dart';
import 'package:remote/src/exception/remote_exception.dart';

extension DioExceptionExtension on DioException {
  RemoteApiException get remoteApiException {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ApiConnectionTimeoutException(this, stackTrace);
      case DioExceptionType.badResponse:
        final tempResponse = response;
        if (tempResponse != null) {
          final statusMessage = tempResponse.statusMessage;
          final errorMessage = statusMessage != null
              ? (tempResponse.data as Map<String, dynamic>)['message'] as String
              : '';
          final statusCode = tempResponse.statusCode ?? 0;

          if (statusCode == 401) {
            return ApiAuthenticationException(errorMessage, this, stackTrace);
          }
          if (statusCode >= 400 && statusCode < 500) {
            return ApiClientException(errorMessage, this, stackTrace);
          }
          if (statusCode >= 500) {
            return ApiServerException(errorMessage, this, stackTrace);
          }
        } else {
          return ApiUnknownException(this, stackTrace);
        }
      default:
        return ApiUnknownException(this, stackTrace);
    }
    return ApiUnknownException(this, stackTrace);
  }
}
