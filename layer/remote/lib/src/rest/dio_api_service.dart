import 'package:dio/dio.dart';
import 'package:remote/src/rest/dio_exception_extension.dart';
import 'package:remote/src/rest/rest_api_service.dart';

class DioApiService implements RestApiService {
  DioApiService(this._dio);

  final Dio _dio;

  @override
  Future<T?> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } catch (error) {
      if (error is DioException) {
        throw error.remoteApiException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<T?> post<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } catch (error) {
      if (error is DioException) {
        throw error.remoteApiException;
      } else {
        rethrow;
      }
    }
  }
}
