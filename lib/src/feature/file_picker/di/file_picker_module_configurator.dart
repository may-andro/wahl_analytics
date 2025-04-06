import 'dart:async';

import 'package:dependency_injection/dependency_injection.dart';
import 'package:wahl_analytics/src/feature/file_picker/domain/domain.dart';

class FilePickerModuleConfigurator implements ModuleConfigurator {
  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    serviceLocator.registerFactory(() => FilePickerUseCase());

    serviceLocator.registerFactory(() => FileOpenerUseCase());
  }
}
