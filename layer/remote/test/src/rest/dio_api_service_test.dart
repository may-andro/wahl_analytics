import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:remote/src/exception/remote_exception.dart';
import 'package:remote/src/rest/dio_api_service.dart';

const _baseUrl = 'https://example.com';

void main() {
  group(DioApiService, () {
    late DioApiService dioApiService;
    late DioAdapter dioAdapter;
    late Dio dio;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: _baseUrl));
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;

      dioApiService = DioApiService(dio);
    });

    group('get', () {
      test('should return response when the dio status code is 20x', () async {
        const path = '/path';
        const response = {'message': 'Success'};
        dioAdapter.onGet(path, (request) => request.reply(200, response));

        final result = await dioApiService.get<Map<String, dynamic>>(path);

        expect(result, isNotNull);
        expect(result, response);
      });

      test('should return $ApiAuthenticationException'
          ' when the dio status code 401', () {
        const path = '/path';
        const response = {'message': 'error'};
        dioAdapter.onGet(path, (request) => request.reply(401, response));

        expect(
          dioApiService.get<dynamic>(path),
          throwsA(isA<ApiAuthenticationException>()),
        );
      });

      test('should return $ApiClientException'
          ' when the dio status code is not 404', () {
        const path = '/path';
        const response = {'message': 'error'};
        dioAdapter.onGet(path, (request) => request.reply(404, response));

        expect(
          dioApiService.get<dynamic>(path),
          throwsA(isA<ApiClientException>()),
        );
      });

      test('should return $ApiClientException'
          ' when the dio status code is not 500', () {
        const path = '/path';
        const response = {'message': 'error'};
        dioAdapter.onGet(path, (request) => request.reply(500, response));

        expect(
          dioApiService.get<dynamic>(path),
          throwsA(isA<ApiServerException>()),
        );
      });

      test('should return $ApiConnectionTimeoutException'
          ' when the dio error is ${DioExceptionType.sendTimeout}', () {
        const path = '/path';
        const type = DioExceptionType.sendTimeout;
        dioAdapter.onGet(
          path,
          (request) => request.throws(
            200,
            DioException(requestOptions: RequestOptions(), type: type),
          ),
        );

        expect(
          () async => await dioApiService.get<dynamic>(path),
          throwsA(isA<ApiConnectionTimeoutException>()),
        );
      });

      test('should return $ApiUnknownException'
          ' when the dio error is unknown', () {
        const path = '/path';
        dioAdapter.onGet(
          path,
          (request) => request.throws(
            200,
            DioException(requestOptions: RequestOptions()),
          ),
        );

        expect(
          () async => await dioApiService.get<dynamic>(path),
          throwsA(isA<ApiUnknownException>()),
        );
      });
    });

    group('post', () {
      test('should return response when the dio status code is 20x', () async {
        const path = '/path';
        const response = {'message': 'Success Post'};
        dioAdapter.onPost(path, (request) => request.reply(201, response));

        final result = await dioApiService.post<dynamic>(path);

        expect(result, response);
      });

      test('should return $ApiAuthenticationException'
          ' when the dio status code 401', () {
        const path = '/path';
        const response = {'message': 'error'};
        dioAdapter.onPost(path, (request) => request.reply(401, response));

        expect(
          dioApiService.post<dynamic>(path),
          throwsA(isA<ApiAuthenticationException>()),
        );
      });

      test('should return $ApiClientException'
          ' when the dio status code is not 404', () {
        const path = '/path';
        const response = {'message': 'error'};
        dioAdapter.onPost(path, (request) => request.reply(404, response));

        expect(
          dioApiService.post<dynamic>(path),
          throwsA(isA<ApiClientException>()),
        );
      });

      test('should return $ApiServerException'
          ' when the dio status code is not 500', () {
        const path = '/path';
        const response = {'message': 'error'};
        dioAdapter.onPost(path, (request) => request.reply(500, response));

        expect(
          dioApiService.post<dynamic>(path),
          throwsA(isA<ApiServerException>()),
        );
      });

      test('should return $ApiConnectionTimeoutException'
          ' when the dio error is ${DioExceptionType.sendTimeout}', () {
        const path = '/path';
        const type = DioExceptionType.sendTimeout;

        dioAdapter.onPost(
          path,
          (request) => request.throws(
            200,
            DioException(requestOptions: RequestOptions(), type: type),
          ),
        );

        expect(
          () async => await dioApiService.post<dynamic>(path),
          throwsA(isA<ApiConnectionTimeoutException>()),
        );
      });

      test('should return $ApiUnknownException'
          ' when the dio error is unknown', () {
        const path = '/path';

        dioAdapter.onPost(
          path,
          (request) => request.throws(
            200,
            DioException(requestOptions: RequestOptions()),
          ),
        );

        expect(
          () async => await dioApiService.post<dynamic>(path),
          throwsA(isA<ApiUnknownException>()),
        );
      });
    });
  });
}
