import 'dart:async';

import 'package:dependency_injection/dependency_injection.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:log_reporter/log_reporter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:remote/src/rest/dio_api_service.dart';
import 'package:remote/src/rest/rest_api_service.dart';

class RemoteModuleConfigurator implements ModuleConfigurator {
  RemoteModuleConfigurator(
    this.isLoggingEnabled,
    this.baseUrl,
  );

  final bool isLoggingEnabled;
  final String baseUrl;

  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    final logReporter = serviceLocator.get<LogReporter>();
    final dio = Dio();

    dio.options = BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    );

    if (isLoggingEnabled) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      );
    }

    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        logPrint: (message) => logReporter.error(message),
      ),
    );

    serviceLocator.registerSingleton<RestApiService>(() => DioApiService(dio));
  }
}
