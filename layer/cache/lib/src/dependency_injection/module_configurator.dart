import 'dart:async';

import 'package:dependency_injection/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheModuleConfigurator implements ModuleConfigurator {
  const CacheModuleConfigurator();

  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) => null;

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    serviceLocator.registerSingleton<SharedPreferences>(
      () => sharedPreferences,
    );
  }

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {}
}
