import 'dart:async';

import 'package:core/core.dart';
import 'package:dependency_injection/dependency_injection.dart';
import 'package:firebase/firebase.dart';
import 'package:wahl_analytics/src/feature/summary/data/data.dart';
import 'package:wahl_analytics/src/feature/summary/domain/domain.dart';

class SummaryModuleConfigurator implements ModuleConfigurator {
  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    serviceLocator.registerFactory<SummaryRepository>(
      () => SummaryRepositoryImpl(
        serviceLocator.get<AppLocale>(),
        serviceLocator.get<BuildConfig>(),
        serviceLocator.get<FbFirestoreController>(),
        BusinessSummaryMapper(),
      ),
    );

    serviceLocator.registerFactory(
      () => GetBusinessSummaryUseCase(serviceLocator.get<SummaryRepository>()),
    );
  }
}
