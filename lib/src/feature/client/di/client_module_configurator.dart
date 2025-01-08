import 'dart:async';

import 'package:core/core.dart';
import 'package:dependency_injection/dependency_injection.dart';
import 'package:firebase/firebase.dart';
import 'package:wahl_analytics/src/feature/client/data/data.dart';
import 'package:wahl_analytics/src/feature/client/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';

class ClientModuleConfigurator implements ModuleConfigurator {
  @override
  FutureOr<void> postDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> preDependenciesSetup(ServiceLocator serviceLocator) {}

  @override
  FutureOr<void> registerDependencies(ServiceLocator serviceLocator) {
    serviceLocator.registerFactory<ClientRepository>(
      () => ClientRepositoryImpl(
        serviceLocator.get<AppLocale>(),
        serviceLocator.get<BuildConfig>(),
        serviceLocator.get<FbFirestoreController>(),
        BusinessClientMapper(ClientMapper(ServiceMapper())),
      ),
    );

    serviceLocator.registerFactory(
      () => GetBusinessClientUseCase(serviceLocator.get<ClientRepository>()),
    );
  }
}
