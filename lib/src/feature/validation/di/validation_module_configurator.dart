import 'dart:async';

import 'package:dependency_injection/dependency_injection.dart';
import 'package:wahl_analytics/src/feature/validation/domain/domain.dart';

class ValidationModuleConfigurator implements ModuleConfigurator {
  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    serviceLocator.registerFactory(() => IsValidCountryUseCase());
    serviceLocator.registerFactory(() => IsValidEmailUseCase());
    serviceLocator.registerFactory(() => IsValidNameUseCase());
    serviceLocator.registerFactory(() => IsValidRoleUseCase());
    serviceLocator.registerFactory(() => IsValidMessageUseCase());
    serviceLocator.registerFactory(() => IsValidVerificationCodeUseCase());
  }
}
