import 'dart:async';

import 'package:core/core.dart';
import 'package:dependency_injection/dependency_injection.dart';

class AppLocaleConfigurator implements ModuleConfigurator {
  AppLocaleConfigurator(this._appLocale);

  final AppLocale _appLocale;

  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) => null;

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    serviceLocator.registerSingleton(() => _appLocale);
  }
}
