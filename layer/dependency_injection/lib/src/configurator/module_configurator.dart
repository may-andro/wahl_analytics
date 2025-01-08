import 'dart:async';

import 'package:dependency_injection/src/service_locator/service_locator.dart';

abstract class ModuleConfigurator {
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator);

  FutureOr<void> registerDependencies(ServiceLocator serviceLocator);

  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator);
}
