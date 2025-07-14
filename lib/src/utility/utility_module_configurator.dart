import 'dart:async';

import 'package:dependency_injection/dependency_injection.dart';
import 'package:log_reporter/log_reporter.dart';
import 'package:wahl_analytics/src/utility/app_bloc_observer.dart';
import 'package:wahl_analytics/src/utility/log_use_case_interceptor.dart';

class UtilityModuleConfigurator implements ModuleConfigurator {
  UtilityModuleConfigurator();

  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) => null;

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) => null;

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    serviceLocator.registerFactory(
      () => LogUseCaseInterceptor(serviceLocator.get<LogReporter>()),
    );

    serviceLocator.registerFactory(
      () => AppBlocObserver(serviceLocator.get<LogReporter>()),
    );
  }
}
