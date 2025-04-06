import 'dart:async';

import 'package:dependency_injection/dependency_injection.dart';
import 'package:wahl_analytics/src/feature/url_handler/domain/use_case/use_case.dart';

class UrlHandlerModuleConfigurator implements ModuleConfigurator {
  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    serviceLocator.registerFactory(() => OpenExternalUrlUseCase());
  }
}
