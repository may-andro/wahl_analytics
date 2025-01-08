import 'dart:async';

import 'package:core/core.dart';
import 'package:dependency_injection/dependency_injection.dart';
import 'package:error_reporter/error_reporter.dart';
import 'package:flutter/foundation.dart';
import 'package:log_reporter/log_reporter.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/error_reporter/app_blacklist_error_handler.dart';
import 'package:wahl_analytics/src/error_reporter/app_fatal_exception_handler.dart';
import 'package:wahl_analytics/src/route/route.dart';
import 'package:wahl_analytics/src/utility/app_bloc_observer.dart';
import 'package:wahl_analytics/src/utility/log_use_case_interceptor.dart';

final ServiceLocator appServiceLocator = DIController().serviceLocator;

class AppModuleConfigurator implements ModuleConfigurator {
  AppModuleConfigurator(this._buildConfig);

  final BuildConfig _buildConfig;

  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) {
    final errorReporter = appServiceLocator.get<ErrorReporter>();

    /// uncaught asynchronous errors that aren't handled by the Flutter framework
    PlatformDispatcher.instance.onError = (error, stack) {
      errorReporter.globalErrorHandler(error, stack);
      return true;
    };

    /// set use case interceptor
    appServiceLocator
        .get<UseCaseInterceptorController>()
        .register(appServiceLocator.get<LogUseCaseInterceptor>());

    /// set blacklist error
    appServiceLocator
        .get<BlacklistErrorController>()
        .register(AppBlacklistErrorHandler());

    /// set fatal error handler
    appServiceLocator
        .get<FatalErrorController>()
        .register(AppFatalErrorHandler());
  }

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) => null;

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) async {
    serviceLocator.registerSingleton(() => _buildConfig);

    serviceLocator.registerFactory(
      () => LogUseCaseInterceptor(serviceLocator.get<LogReporter>()),
    );

    serviceLocator.registerFactory(
      () => AppBlocObserver(serviceLocator.get<LogReporter>()),
    );

    serviceLocator.registerSingleton(
      () => ModuleRouteController(serviceLocator.get<LogReporter>()),
    );

    serviceLocator.registerFactory(
      () => RouteNavigationObserver(serviceLocator.get<LogReporter>()),
    );
  }
}
