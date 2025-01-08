import 'dart:async';

import 'package:dependency_injection/dependency_injection.dart';
import 'package:use_case/src/interceptor/interceptor.dart';

class UseCaseModuleConfigurator implements ModuleConfigurator {
  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) => null;

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) => null;

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    serviceLocator.registerFactory(() => UseCaseInterceptorController());
  }
}
