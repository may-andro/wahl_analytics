abstract class RestApiService {
  Future<T?> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  });

  Future<T?> post<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  });
}
